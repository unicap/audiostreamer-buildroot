#!/bin/sh
. /mnt/mmcblk0p1/userconfig.txt

export LD_LIBRARY_PATH=/lib

sleep 2
# Debugging immer an lassen, um LMS-Status greppen zu koennen
DEBUG="ON"

if pgrep squeezelite ; then killall squeezelite ; fi
if pgrep shairport ; then killall  shairport ; fi
if pgrep gmediarender ; then killall gmediarender ; fi

ethaddr()
{
	ETHADDR=$(ifconfig | grep -A 2 eth0 | grep -w inet -m1 | grep -v 127 | awk -F[:] '{ print $2  }' | awk -F[:' '] '{ print $1 }')
}
wlanaddr()
{
	WLANADDR=$(ifconfig | grep -A 2 wlan0 | grep -w inet -m1 | grep -v 127 | awk -F[:] '{ print $2  }' | awk -F[:' '] '{ print $1 }')
}

gmedia()
{
	MACADDR=$(cat /sys/class/net/eth0/address)
	echo "starte function gmrender"
	if [ "$BRUTEFIR" = "OFF" ]
	then
		if [ "$MSCODING" = "ON" ]
		then
			echo "function gmediarender starting player mscoded"
			gmediarender -u "$MACADDR" -d -f "$PLAYERNAME"-upnp --gstout-audiosink=alsasink --gstout-audiodevice=mscoded
		else
			echo "function gmediarender starting player stereo"
			gmediarender -u "$MACADDR" -d -f "$PLAYERNAME"-upnp --gstout-audiosink=alsasink --gstout-audiodevice=stereo
		fi
	else
		echo "function gmediarender starting player jacked"
		gmediarender -u "$MACADDR" -d -f "$PLAYERNAME"-upnp --gstout-audiosink=jackaudiosink --gstout-audiostringproperties=port-pattern=brutefir
	fi
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
			PLAYER="shairport-sync"
			if [ "$MSCODING" = "ON" ] ; then
				OUTPUT=" -o alsa -- -d mscoded"
			else 	OUTPUT=" -o alsa -- -d stereo"
			fi
		else
			PLAYER="shairport-sync-jack "
			OUTPUT=" -o jack -- brutefir"
		fi

		$PLAYER -v -w -B /usr/bin/shairport-sync-startaction -E /usr/bin/shairport-sync-stopaction \
		-a "$PLAYERNAME" $OUTPUT &> /var/log/shairportlog.txt
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
		PLAYER="squeezelite"
		ALSAPARAMS="-a 8192:1024:32:0 -b 1024:8192"
		RATE=""
		RESAMPLE=""
		if [ "$MSCODING" = "ON" ]
		then
			OUTPUT="-o mscoded"
			echo "             Output is MS-coded!"
#		else	OUTPUT="-o stereo"
		else	OUTPUT="-o plughw:0,0"
			echo "             Output is stereo!"
		fi
	else
		echo -e "             Output through brutefir,"
		if [ "$MSCODING" = "ON" ]
		then	echo "             ms-coded!"
		else	echo "             stereo!"
		fi
		PLAYER='squeezelite-jack -a brutefir '
		RATE="-r 96000-96000 "
		RESAMPLE="-R -u hL"
	#	ALSAPARAMS="-b 8192:16384"
                ALSAPARAMS="-b 1024:16384"
fi

	$PLAYER -p 99 -m "$MACADDR" -n "$PLAYERNAME" -s "$SERVERNAME" -z \
	$OUTPUT $DEBUGSQUEEZE $RATE $RESAMPLE $ALSAPARAMS
}

while (true)
do
	# If brutefir should be running, check that and wait if needed
	if [ "$BRUTEFIR" = "ON" ] ; then until pgrep -x brutefir &> /dev/null ; do sleep 0.2 ; done ; fi


	if [ "$BRUTEFIR" = "OFF" ]
	then
		if [ "$AUDIOPLAYER" = "squeezelite" ]
		then
			#echo "starte squeeze"
			if ! pgrep -x squeezelite &> /dev/null
			then
				squeeze
			fi
		fi

		if [ "$AUDIOPLAYER" = "gmediarender" ]
		then
			sleep 1
			if ! pgrep -x gmediarender &> /dev/null
			then
				#echo "starte gmediarender"
				gmedia
			fi
		fi
	else
		if ! pgrep -x squeezelite &> /dev/null
		then
			squeeze
		fi

		if [ "$AUDIOPLAYER" = "gmediarender" ]
		then
			if ! pgrep -x gmediarender &> /dev/null
		        then
			        gmedia
		        fi
		fi
	fi

	sleep 1
	if ! pgrep -x shairport-sync &> /dev/null ; then shair ; fi
done
