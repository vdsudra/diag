#!/bin/bash

# File      : sdcard_write.sh
# brief     : Script to write data on SD card

#TIMESTAMP=`date +"[%a %b %_e %H:%M:%S %Y]"`
#echo "$TIMESTAMP : "" " >> $LOGPATH 

# CONSTANTS
LOGPATH="/home/vinay/work/application/diag/diag_logs"
RET=1

# Checking SD card is connection
echo "Checking SD card....."
TIMESTAMP=`date +"[%a %b %_e %H:%M:%S %Y]"`
echo "$TIMESTAMP : ""Checking SD card.....\n" >> $LOGPATH 

MOUNTPOINT=$(grep "mmcblk0" /proc/mounts | awk '{print $2}')
if [ $? -ne 0 ];
then
    echo "Failed to find mount point"
    TIMESTAMP=`date +"[%a %b %_e %H:%M:%S %Y]"`
    echo "$TIMESTAMP : ""Failed to find mount point" >> $LOGPATH 
else
    if [ "$MOUNTPOINT" = "" ];
    then
	echo "SD card is not mounted so mount it by using 'sdcard detect' option"
	TIMESTAMP=`date +"[%a %b %_e %H:%M:%S %Y]"`
	echo "$TIMESTAMP : ""SD card is not mounted so mount it by using 'sdcard detect' option" >> $LOGPATH 
    else
	echo "SD card mounted on '$MOUNTPOINT'"
	TIMESTAMP=`date +"[%a %b %_e %H:%M:%S %Y]"`
	echo "$TIMESTAMP : ""SD card mounted on '$MOUNTPOINT'" >> $LOGPATH 
    fi
fi

if [ "$MOUNTPOINT" != "" ];
then
    echo "Performing Write operation on SD card 1"
    TIMESTAMP=`date +"[%a %b %_e %H:%M:%S %Y]"`
    echo "$TIMESTAMP : ""Performing Write operation on SD card 1" >> $LOGPATH 
    echo "Test Ok!" > "$MOUNTPOINT"/"test.txt"
    if [ $?  !=  0 ];
    then
	echo "Write fails on test.txt"
	TIMESTAMP=`date +"[%a %b %_e %H:%M:%S %Y]"`
	echo "$TIMESTAMP : ""Write fails on test.txt" >> $LOGPATH 
    else
	echo "Test Ok! on SD card"
	TIMESTAMP=`date +"[%a %b %_e %H:%M:%S %Y]"`
	echo "$TIMESTAMP : ""Test Ok! on SD card" >> $LOGPATH 
	RET=0
    fi
fi

exit $RET
