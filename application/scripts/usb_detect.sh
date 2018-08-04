#!/bin/bash

# File      : usb_detect.sh
# brief     : Script to detect usb

#TIMESTAMP=`date +"[%a %b %_e %H:%M:%S %Y]"`
#echo "$TIMESTAMP : "" " >> $LOGPATH 

# CONSTANTS
RET=-1
LOGPATH="/home/santoshm/work/application/diag/diag_logs"

# Checking SD card is connection
echo -e "Testing USB.....\n"
TIMESTAMP=`date +"[%a %b %_e %H:%M:%S %Y]"`
echo "$TIMESTAMP : ""Testing USB....." >> $LOGPATH 

USB_DEVICE=`lsblk -l | grep "sd.1"`
if [ $? -ne 0 ];
then
    echo "Fail to find device."
    TIMESTAMP=`date +"[%a %b %_e %H:%M:%S %Y]"`
    echo "$TIMESTAMP : ""Fail to find device." >> $LOGPATH
    exit $RET
fi

USB0=`echo "$USB_DEVICE" |  sed -n 1p | awk '{print $1}'`
USB1=`echo "$USB_DEVICE" |  sed -n 2p | awk '{print $1}'`

if [ $USB0 ];
then
    echo "USB 1 found."
    TIMESTAMP=`date +"[%a %b %_e %H:%M:%S %Y]"`
    echo "$TIMESTAMP : ""USB 1 found." >> $LOGPATH
fi

if [ $USB1 ];
then
    echo "USB 2 found."
    TIMESTAMP=`date +"[%a %b %_e %H:%M:%S %Y]"`
    echo "$TIMESTAMP : ""USB 2 found." >> $LOGPATH
fi

if [ $USB0 ];
then
    MOUNTPOINT1=$(grep "$USB0" /proc/mounts | awk '{print $2}')
    if [ $? -ne 0 ];
    then
	echo "Failed to find mount point 1"
	TIMESTAMP=`date +"[%a %b %_e %H:%M:%S %Y]"`
	echo "$TIMESTAMP : ""Failed to find mount point 1" >> $LOGPATH
    else
	if [ "$MOUNTPOINT1" = "" ];
	then
	    echo "USB 1 is not mounted so mounting..."
	    TIMESTAMP=`date +"[%a %b %_e %H:%M:%S %Y]"`
	    echo "$TIMESTAMP : ""USB 1 is not mounted so mounting..." >> $LOGPATH
	    mkdir /media/sd0
	    mount /dev/"$USB0" /media/sd0
	    if [ $? -eq 0 ];
	    then
		echo "USB 1 mounted on '/media/sd0'"
		TIMESTAMP=`date +"[%a %b %_e %H:%M:%S %Y]"`
		echo "$TIMESTAMP : ""USB 1 mounted on '/media/sd0'" >> $LOGPATH 
		RET=0
	    else 
		echo "Unable to mount USB 1 on '/media/sd0'"
		TIMESTAMP=`date +"[%a %b %_e %H:%M:%S %Y]"`
		echo "$TIMESTAMP : ""Unable to mount USB 1 on '/media/sd0'" >> $LOGPATH
	    fi
	else
	    echo "USB 1 mounted on '$MOUNTPOINT1'"
	    TIMESTAMP=`date +"[%a %b %_e %H:%M:%S %Y]"`
	    echo "$TIMESTAMP : ""USB 1 mounted on '$MOUNTPOINT1'" >> $LOGPATH
	    RET=0
	fi
    fi
fi

if [ $USB1 ]
then
    MOUNTPOINT2=$(grep "$USB1" /proc/mounts | awk '{print $2}')
    if [ $? -ne 0 ];
    then
	echo "Failed to find mount point 2"
	TIMESTAMP=`date +"[%a %b %_e %H:%M:%S %Y]"`
	echo "$TIMESTAMP : ""Failed to find mount point 2" >> $LOGPATH
    else
	if [ "$MOUNTPOINT2" = "" ];
	then
	    echo "USB 2 is not mounted so mounting..."
	    TIMESTAMP=`date +"[%a %b %_e %H:%M:%S %Y]"`
	    echo "$TIMESTAMP : ""USB 2 is not mounted so mounting..." >> $LOGPATH
	    mkdir /media/sd1
	    mount /dev/"$USB1" /media/sd1
	    if [ $? -eq 0 ];
	    then
		echo "USB 2 mounted on '/media/sd1'"
		TIMESTAMP=`date +"[%a %b %_e %H:%M:%S %Y]"`
		echo "$TIMESTAMP : ""USB 2 mounted on '/media/sd1'" >> $LOGPATH 
		RET=0
	    else 
		echo "Unable to mount USB 2 on '/media/sd1'"
		TIMESTAMP=`date +"[%a %b %_e %H:%M:%S %Y]"`
		echo "$TIMESTAMP : ""Unable to mount USB 2 on '/media/sd1'" >> $LOGPATH
	    fi
	else
	    echo "USB 2 mounted on '$MOUNTPOINT2'"
	    TIMESTAMP=`date +"[%a %b %_e %H:%M:%S %Y]"`
	    echo "$TIMESTAMP : ""USB 2 mounted on '$MOUNTPOINT2'" >> $LOGPATH
	    RET=0
	fi
    fi
fi
exit $RET
