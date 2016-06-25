#!/bin/sh

. /mnt/mmcblk0p1/userconfig.txt

for i in $(grep -o "COEFF[^m]_NAME" /mnt/mmcblk0p1/userconfig.txt)
do
	echo $i
done
