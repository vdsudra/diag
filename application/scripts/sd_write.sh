#!/bin/bash

# File      : sdcard_write.sh
# brief     : Script to write data on SD card

# CONSTANTS
RET=-1

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
    echo "Performing Write operation on SD card 1"
    echo "Test Ok!" > "$MOUNTPOINT"/"test.txt"
    if [ $?  !=  0 ];
    then
	echo "Write fails on test.txt"
    else
	echo "Test Ok! on SD card"
	RET=0
    fi
fi

exit $RET
