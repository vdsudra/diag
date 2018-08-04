#!/bin/bash

# File      : sdcard_detect.sh
# brief     : Script to detect SD card

#TIMESTAMP=`date +"[%a %b %_e %H:%M:%S %Y]"`
#echo "$TIMESTAMP : "" " >> $LOGPATH 

# CONSTANTS
LOGPATH="/home/santoshm/work/application/diag/diag_logs"
RET=-1
MMC0=0

echo -e "Testing SD card.....\n"
TIMESTAMP=`date +"[%a %b %_e %H:%M:%S %Y]"`
echo "$TIMESTAMP : ""Testing SD card.....\n" >> $LOGPATH 

lsblk | grep "mmcblk0" > /dev/null
if [ $? -eq 0 ];
then
    echo "SD card connection found."
    TIMESTAMP=`date +"[%a %b %_e %H:%M:%S %Y]"`
    echo "$TIMESTAMP : ""SD card connection found." >> $LOGPATH 
    MMC0=1
else
    echo "SD card not connected."
    TIMESTAMP=`date +"[%a %b %_e %H:%M:%S %Y]"`
    echo "$TIMESTAMP : ""SD card not connected." >> $LOGPATH 
fi


if [ "$MMC0" == "1" ]
then
    MOUNTPOINT=$(grep "mmcblk0" /proc/mounts | awk '{print $2}')
    if [ $? -ne 0 ];
    then
	echo "Failed to find mount point"
	TIMESTAMP=`date +"[%a %b %_e %H:%M:%S %Y]"`
	echo "$TIMESTAMP : ""Failed to find mount point" >> $LOGPATH 
    else
	if [ "$MOUNTPOINT" = "" ];
	then
	    echo "SD card not mounted so mounting sd card"
	    TIMESTAMP=`date +"[%a %b %_e %H:%M:%S %Y]"`
	    echo "$TIMESTAMP : ""SD card not mounted so mounting sd card" >> $LOGPATH 
	    mkdir /media/mmcblk0
	    mount /dev/mmcblk0 /media/mmcblk0
	    if [ $? -eq 0 ];
	    then
		echo "SD card mounted on '/media/mmcblk0'"
		TIMESTAMP=`date +"[%a %b %_e %H:%M:%S %Y]"`
		echo "$TIMESTAMP : ""SD card mounted on '/media/mmcblk0'" >> $LOGPATH 
		RET=0;
	    else 
		echo "Unable to mount SD card on '/media/mmcblk0'"
		TIMESTAMP=`date +"[%a %b %_e %H:%M:%S %Y]"`
		echo "$TIMESTAMP : """ >> $LOGPATH 
	    fi
	else
	    echo "SD card 1 mounted on '$MOUNTPOINT'"
	    TIMESTAMP=`date +"[%a %b %_e %H:%M:%S %Y]"`
	    echo "$TIMESTAMP : "" " >> $LOGPATH 
	    RET=0
	fi
    fi
fi

exit $RET
