#!/bin/bash

# File      : log_usb.sh
# brief     : Script to copy log on usb

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
echo -e "Finding USB to copy log .....\n"
TIMESTAMP=`date +"[%a %b %_e %H:%M:%S %Y]"`
echo "$TIMESTAMP : ""Finding USB to copy log ....." >> $LOGPATH 

USB_DEVICE=`lsblk -l | grep "sd.1"`
if [ $? -ne 0 ];
then
    echo "Fail to find device."
    TIMESTAMP=`date +"[%a %b %_e %H:%M:%S %Y]"`
    echo "$TIMESTAMP : ""Fail to find device for copy." >> $LOGPATH
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
	    echo "USB 1 is not mounted so mount it by using 'usb detect' option"
	    TIMESTAMP=`date +"[%a %b %_e %H:%M:%S %Y]"`
	    echo "$TIMESTAMP : ""USB 1 is not mounted so mount it by using 'usb detect' option" >> $LOGPATH 
	else
	    echo "USB 1 mounted on '$MOUNTPOINT1'"
	    TIMESTAMP=`date +"[%a %b %_e %H:%M:%S %Y]"`
	    echo "$TIMESTAMP : ""USB 1 mounted on '$MOUNTPOINT1'" >> $LOGPATH 
	fi
    fi
fi

if [ $USB1 ];
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
	    echo "USB 2 is not mounted so mount it by using 'usb detect' option"
	    TIMESTAMP=`date +"[%a %b %_e %H:%M:%S %Y]"`
	    echo "$TIMESTAMP : ""USB 2 is not mounted so mount it by using 'usb detect' option" >> $LOGPATH 
	else
	    echo "USB 2 mounted on '$MOUNTPOINT2'"
	    TIMESTAMP=`date +"[%a %b %_e %H:%M:%S %Y]"`
	    echo "$TIMESTAMP : ""USB 2 mounted on '$MOUNTPOINT2'" >> $LOGPATH 
	fi
    fi
fi


# check mount to USB
if [ "$MOUNTPOINT1" != "" ];
then
    echo "Performing copy operation on USB 1"
    TIMESTAMP=`date +"[%a %b %_e %H:%M:%S %Y]"`
    echo "$TIMESTAMP : ""Performing copy operation on USB 1" >> $LOGPATH 
    $(cp "$LOGPATH $MOUNTPOINT1")
    if [ $?  !=  0 ];
    then
	echo "Failed to copy log on USB 1"
	TIMESTAMP=`date +"[%a %b %_e %H:%M:%S %Y]"`
	echo "$TIMESTAMP : ""Failed to copy log on USB 1" >> $LOGPATH 
    else
	echo "Log copied on USB 1"
	TIMESTAMP=`date +"[%a %b %_e %H:%M:%S %Y]"`
	echo "$TIMESTAMP : ""Log copied on USB 1" >> $LOGPATH 
	RET=0
    fi
fi

if [ "$MOUNTPOINT2" != "" ];
then
    echo "Performing copy operation on USB 2"
    TIMESTAMP=`date +"[%a %b %_e %H:%M:%S %Y]"`
    echo "$TIMESTAMP : ""Performing copy operation on USB 2" >> $LOGPATH 
    $(cp "$LOGPATH $MOUNTPOINT2")
    if [ $?  !=  0 ];
    then
	echo "Failed to copy log on USB 2"
	TIMESTAMP=`date +"[%a %b %_e %H:%M:%S %Y]"`
	echo "$TIMESTAMP : ""Failed to copy log on USB 2" >> $LOGPATH 
    else
	echo "Log copied on USB 2"
	TIMESTAMP=`date +"[%a %b %_e %H:%M:%S %Y]"`
	echo "$TIMESTAMP : ""Log copied on USB 2" >> $LOGPATH 
	RET=0
    fi
fi

exit $RET
