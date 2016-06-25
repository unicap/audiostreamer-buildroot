#!/bin/sh
. /mnt/mmcblk0p1/userconfig.txt

export LD_LIBRARY_PATH=/lib

sleep 2
# Debugging immer an lassen, um LMS-Status greppen zu koennen
DEBUG="ON"

if pgrep squeezelite ; then killall squeezelite ; fi
if pgrep shairport ; then killall  shairport ; fi

ethaddr()
{
	ETHADDR=$(ifconfig | grep -A 2 eth0 | grep -w inet -m1 | grep -v 127 | awk -F[:] '{ print $2  }' | awk -F[:' '] '{ print $1 }')
}
wlanaddr()
{
	WLANADDR=$(ifconfig | grep -A 2 wlan0 | grep -w inet -m1 | grep -v 127 | awk -F[:] '{ print $2  }' | awk -F[:' '] '{ print $1 }')
}

shair()
{
	ethaddr
	wlanaddr

	until ! [ "$ETHADDR" = "" ] || ! [ "$WLANADDR" = "" ]
	do
		echo "Shairport:   Network not available, waiting..."
		sleep 2
		ethaddr
		wlanaddr
	done

	echo "Shairport:   Starting up..."
	echo "             Booting took us $(cat /proc/uptime | awk '{print $1}') seconds"

		if [ "$DEBUG" = "ON" ] ; then
			touch /var/log/shairportlog.txt
		fi

		if [ "$BRUTEFIR" = "OFF" ] ; then
			if [ "$MSCODING" = "ON" ] ; then
				OUTPUT="-o alsa -- -d mscoded"
			else 	OUTPUT="-o alsa -- -d stereo"
			fi
		else	OUTPUT='-o alsa -- -d jackplug'
		fi
		shairport-sync -v -w -B /usr/bin/shairport-sync-startaction -E /usr/bin/shairport-sync-stopaction \
		-a "$PLAYERNAME" $OUTPUT  &> /var/log/shairportlog.txt
}

squeeze(){
	if ! [ "$SERVERNAME" = ""  ]
	then
		if ! (ping -c1 $SERVERNAME) &> /dev/null
		then
			#echo "Squeezelite: Squeezebox-Server "$SERVERNAME" not available, waiting..."
			until (ping -c1 $SERVERNAME) &> /dev/null
			do
				sleep 0.2
			done
		fi
	else
		until (ping -c1 127.0.0.1) &> /dev/null
		do
			sleep 0.3
		done
	echo "Squeezelite: Network available!"
	fi

	sleep 1
	if grep 1 /sys/class/net/eth0/carrier &> /dev/null
	then	MACADDR=$(cat /sys/class/net/eth0/address)
	else	MACADDR=$(cat /sys/class/net/wlan0/address)
	fi

	if ! [ "$SERVERNAME" = "" ]
	then
		echo -e "Squeezelite: LMS-Server available, starting up..."
	else
		echo "Squeezelite: LMS-Server set to be automagically detected, starting up."
	fi
		if [ "$DEBUG" = "ON" ]
		then
			echo "             Debugging activated in userconfig.txt, logging to /var/log/"
			DEBUGSQUEEZE="-d all=info -f /var/log/squeezelitelog.txt"
	else
		DEBUG=""
	fi

	# squeezelite buffer parameters:
	#   -a <b>:<p>:<t>:<m>
	#      b = buffer size in Bytes or ms (if smaller 500), default 40
	#      p = period count (if < 50) or size in Bytes, default 4 periods
	#      f = sample format (16|24|24_3|32)
	#      m = use mmap
	#
	#   -b <streambuffer>:<outputbufer>
	#      internal stream and output buffer sizes in kilobytes, default is close to 2048:3446
	#   -r sample rates  supported  by the output device, must be different for stereo than for jackplug!!!
	#      -r 96000 menas max supported rate, resample all above
	#      -r 96000-96000 means resample anything but 96000

	if [ "$BRUTEFIR" = "OFF" ]
	then
#		ALSAPARAMS="-a 65536:1024:24:1"
		ALSAPARAMS="-a ::24:1"
		RATE="-r 96000"
		RESAMPLE=""
		if [ "$MSCODING" = "ON" ]
		then
			OUTPUT="-o mscoded"
			echo "             Output is MS-coded!"
		else	OUTPUT="-o stereo"
			echo "             Output is stereo!"
		fi
	else
		echo -e "             Output through brutefir,"
		if [ "$MSCODING" = "ON" ]
		then	echo "             ms-coded!"
		else	echo "             stereo!"
		fi
#		ALSAPARAMS="-a 65536:1024:32:1 -b :8192"	so lala, kanckt selten
#		ALSAPARAMS="-a ::32:1 -b :8192"			nicht so prima
#		ALSAPARAMS="-a 65535:1024:32:0 -b :8192"	knackt
		ALSAPARAMS="-a 65536:1024:32:1 -b :8192"
		OUTPUT="-o jackplug"
		RATE="-r 96000-96000"
		RESAMPLE="-R -u hL"
	fi

	squeezelite -p 99 -m "$MACADDR" -n "$PLAYERNAME" -s "$SERVERNAME" -z \
	$OUTPUT $DEBUGSQUEEZE $RATE $ALSAPARAMS $RESAMPLE
}

while (true)
do
	if [ "$BRUTEFIR" = "ON" ] ; then until pgrep -x brutefir &> /dev/null ; do sleep 0.2 ; done ; fi
	if ! pgrep -x squeezelite &> /dev/null ;    then squeeze ; fi
	sleep 1
	if ! pgrep -x shairport-sync &> /dev/null ; then shair ; fi
done
