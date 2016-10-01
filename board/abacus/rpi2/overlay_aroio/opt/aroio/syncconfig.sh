#!/bin/sh

# Sync changes to /etc/aroio/userconfig to /mnt/mmcblk0p1/userconfig.txt
while true
do
    if inotifywait -e modify /etc/aroio/userconfig 2>/dev/null >/dev/null
    then
	mount -o remount,rw /mnt/mmcblk0p1
	mv /mnt/mmcblk0p1/userconfig.txt /mnt/mmcblk0p1/userconfig.bak
	cp /etc/aroio/userconfig /mnt/mmcblk0p1/userconfig.txt
	mount -o remount,ro /mnt/mmcblk0p1
    fi
done
