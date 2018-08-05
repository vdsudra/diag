#!/bin/bash

# File      : log_sd.sh
# brief     : Script to copy log on sd card

#TIMESTAMP=`date +"[%a %b %_e %H:%M:%S %Y]"`
#echo "$TIMESTAMP : "" " >> $LOGPATH 

# CONSTANTS
RET=1
LOGPATH="/home/vinay/work/application/diag/diag_logs"

# check log is present or not

if [ ! -f "$LOGPATH" ];
then
    echo "'$file' not available to copy"
    TIMESTAMP=`date +"[%a %b %_e %H:%M:%S %Y]"`
    echo "$TIMESTAMP : ""'$file' not available to copy" >> $LOGPATH
    RET=0
    exit $RET
fi

# Checking SD card is connection
echo -e "Finding SD card to copy log.....\n"
TIMESTAMP=`date +"[%a %b %_e %H:%M:%S %Y]"`
echo "$TIMESTAMP : ""Finding SD card to copy log.....\n" >> $LOGPATH 

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
    echo "Performing copy operation on SD card"
    TIMESTAMP=`date +"[%a %b %_e %H:%M:%S %Y]"`
    echo "$TIMESTAMP : ""Performing copy operation on SD card" >> $LOGPATH 
    $(cp "$LOGPATH $MOUNTPOINT")
    if [ $?  !=  0 ];
    then
	echo "Failed to copy log on SD card"
	TIMESTAMP=`date +"[%a %b %_e %H:%M:%S %Y]"`
	echo "$TIMESTAMP : ""Failed to copy log on SD card" >> $LOGPATH 
    else
	echo "Log copied on SD card"
	TIMESTAMP=`date +"[%a %b %_e %H:%M:%S %Y]"`
	echo "$TIMESTAMP : ""Log copied on SD card" >> $LOGPATH 
	RET=0
    fi
fi

exit $RET
