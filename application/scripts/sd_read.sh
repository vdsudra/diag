#!/bin/bash

# File      : sdcard_read.sh
# brief     : Script to read data from SD card

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
    echo "Performing Read operation on SD card "
    TIMESTAMP=`date +"[%a %b %_e %H:%M:%S %Y]"`
    echo "$TIMESTAMP : ""Performing Read operation on SD card" >> $LOGPATH 
    file=$MOUNTPOINT/"test.txt"
    if [ ! -f "$file" ]
    then
	echo "'$file' not found, create file by 'sdcard write' option"
	TIMESTAMP=`date +"[%a %b %_e %H:%M:%S %Y]"`
	echo "$TIMESTAMP : ""'$file' not found, create file by 'sdcard write' option" >> $LOGPATH 
    else
	DATA=$(cat $file)
	if [ -z "$DATA" ];
	then
	    echo "No data to read from SD card" 
	    TIMESTAMP=`date +"[%a %b %_e %H:%M:%S %Y]"`
	    echo "$TIMESTAMP : ""No data to read from SD card" >> $LOGPATH 
	    RET=0
	else
	    echo "Read '$DATA' from SD card"
	    TIMESTAMP=`date +"[%a %b %_e %H:%M:%S %Y]"`
	    echo "$TIMESTAMP : ""Read '$DATA' from SD card" >> $LOGPATH 
	    RET=0
	fi
    fi
fi

exit $RET
