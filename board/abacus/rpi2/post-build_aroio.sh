#!/bin/bash

set -e

if [ -e userconfig_default.txt ]; then
    echo "Custom userconfig found, copying to target"
    cp userconfig_default.txt ${TARGET_DIR}/etc
fi

echo -n $(git log --format="Commit: %h from %aD" -n 1) > ${TARGET_DIR}/VERSION
echo -n $(git log --format="%ct" -n 1) > ${TARGET_DIR}/VERSION_TIMESTAMP

echo "Cleaning up init scripts"
if [ -e ${TARGET_DIR}/etc/init.d/S05avahi-setup.sh ]; then
    mv ${TARGET_DIR}/etc/init.d/S05avahi-setup.sh ${TARGET_DIR}/etc/init.d/avahi-setup
    mv ${TARGET_DIR}/etc/init.d/S50avahi-daemon ${TARGET_DIR}/etc/init.d/avahi-daemon
fi

if [ -e ${TARGET_DIR}/etc/init.d/S30dbus ]; then
    mv ${TARGET_DIR}/etc/init.d/S30dbus ${TARGET_DIR}/etc/init.d/dbus
fi

if [ -e ${TARGET_DIR}/etc/init.d/S91smb ]; then
    mv ${TARGET_DIR}/etc/init.d/S91smb ${TARGET_DIR}/etc/init.d/smb
fi

if [ ! "${TARGET_DIR}" = "" ]; then
    echo "Removing:"
    ls ${TARGET_DIR}/etc/init.d/S[0-9]* || true
    rm -f ${TARGET_DIR}/etc/init.d/S[0-9]*
fi

rm -f ${TARGET_DIR}/etc/init.d/shairport-sync

# create required empty directories

mkdir -p ${TARGET_DIR}/mnt/mmcblk0p1
mkdir -p ${TARGET_DIR}/mnt/ext
mkdir -p ${TARGET_DIR}/etc/aroio
mkdir -p ${TARGET_DIR}/home/sftparoio
mkdir -p ${TARGET_DIR}/etc/bluetooth/passkeys
mkdir -p ${TARGET_DIR}/etc/dbus-1/session.d


