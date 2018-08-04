#!/bin/bash

# File      : m_2_detect.sh
# brief     : Script to detect m.2 device

# CONSTANTS
RET=-1

# Checking SD card is connection
echo -e "Testing USB.....\n"

lsblk -io NAME,TYPE,SIZE,MOUNTPOINT,FSTYPE,MODEL
lsblk -d -o name,rota | awk '{ if ($2 =="1") print $1 "[HDD]"; else if ($2 =="0") print $1 "[SDD]";}'
USB_DEVICE=`lsblk -l | grep "sd.1"`
if [ $? -ne 0 ];
then
   echo "Fail to find device."
   exit $RET
fi

USB0=`echo "$USB_DEVICE" |  sed -n 1p | awk '{print $1}'`
USB1=`echo "$USB_DEVICE" |  sed -n 2p | awk '{print $1}'`

if [ $USB0 ];
then
    echo "USB 1 found."
fi

if [ $USB1 ];
then
    echo "USB 2 found."
fi

if [ $USB0 ]
then
    MOUNTPOINT1=$(grep "$USB0" /proc/mounts | awk '{print $2}')
    if [ $? -ne 0 ];
    then
	echo "Failed to find mount point 1"
    else
	if [ "$MOUNTPOINT1" = "" ];
	then
	    echo "USB 1 is not mounted so mounting..."
	    mkdir /media/sd0
	    mount /dev/"$USB0" /media/sd0
	    if [ $? -eq 0 ];
	    then
		echo "USB 1 mounted on '/media/sd0'"
		RET=0
	    else 
		echo "Unable to mount USB 1 on '/media/sd0'"
	    fi
	else
	    echo "USB 1 mounted on '$MOUNTPOINT1'"
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
    else
	if [ "$MOUNTPOINT2" = "" ];
	then
	    echo "USB 2 is not mounted so mounting..."
	    mkdir /media/sd1
	    mount /dev/"$USB1" /media/sd1
	    if [ $? -eq 0 ];
	    then
		echo "USB 2 mounted on '/media/sd1'"
		RET=0
	    else 
		echo "Unable to mount USB 2 on '/media/sd1'"
	    fi
	else
	    echo "USB 2 mounted on '$MOUNTPOINT2'"
	    RET=0
	fi
    fi
fi
exit $RET
