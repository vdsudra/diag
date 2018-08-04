#!/bin/bash

# File      : sdcard_read.sh
# brief     : Script to read data from SD card

# CONSTANTS
RET=-1

# Checking SD card is connection
echo -e "Checking SD card.....\n"

MOUNTPOINT=$(grep "mmcblk0" /proc/mounts | awk '{print $2}')
if [ $? -ne 0 ];
then
    echo "Failed to find mount point"
else
    if [ "$MOUNTPOINT" = "" ];
    then
	echo "SD card is not mounted so mount it by using 'sdcard detect' option"
    else
	echo "SD card mounted on '$MOUNTPOINT'"
    fi
fi

if [ "$MOUNTPOINT" != "" ];
then
    echo "Performing Read operation on SD card "
    file=$MOUNTPOINT/"test.txt"
    if [ ! -f "$file" ]
    then
	echo "'$file' not found, create file by 'sdcard write' option"
    else
	DATA=$(cat $file)
	if [ -z "$DATA" ];
	then
	    echo "No data to read from SD card" 
	    RET=0
	else
	    echo "Read '$DATA' from SD card"
	    RET=0
	fi
    fi
fi

exit $RET
