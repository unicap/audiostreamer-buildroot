#!/bin/sh

destdir=/mnt/ext

start_slimserver()
{
    if ! [ -e ${destdir}/lms ]; then
	mkdir ${destdir}/lms
	chown slimserver.slimserver ${destdir}/lms
    fi
    /etc/init.d/slimserver stop
    /etc/init.d/slimserver start
}

stop_slimserver()
{
    /etc/init.d/slimserver stop
}

start_samba()
{
    mkdir -p /var/cache/samba
    mkdir -p /var/lib/samba/private
    mkdir -p /var/lock
    /etc/init.d/S91smb stop
    /etc/init.d/S91smb start
}

stop_samba()
{
    /etc/init.d/S91smb stop
}

my_umount()
{
	if grep -qs "^/dev/$1 " /proc/mounts ; then
		umount "${destdir}";
	fi
}

my_mount()
{
    EXTDEVICE=/dev/$1
    EXTFS=$(eval $(blkid $EXTDEVICE | awk ' { print $4 } '); echo $TYPE)

    if [ $EXTFS ]; then
	echo "Found external storage with fs type: $EXTFS and mounting it"
	EXTUID=$(id -u slimserver)
	EXTGID=$(id -g slimserver)
	case $EXTFS in
	    ntfs )
		ntfs-3g uid=$EXTUID gid=$EXTGID $EXTDEVICE "${destdir}" && EXTPRESENT=yes
		;;
	    * )
		mount $EXTDEVICE "${destdir}" && EXTPRESENT=yes
		chown slimserver:slimserver "${destdir}"
		;;
	esac
    else
	echo "No external storage found, exiting"
	exit -1
    fi
}

case "${ACTION}" in
add|"")
	my_umount ${MDEV}
	my_mount ${MDEV}
	start_slimserver ${MDEV}
	start_samba ${MDEV}
	;;
remove)
	stop_slimserver ${MDEV}
	stop_samba ${MDEV}
	my_umount ${MDEV}
	;;
esac
