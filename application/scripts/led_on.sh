#!/bin/bash

# File      : led_on.sh
# brief     : Script to turn on diag LED

# CONSTANTS
PASSED=0
FAILED=-1

echo -e "Testing Diag LED.\n"
STATE=`cat /sys/class/gpio/gpio8/value` 
if [ $? -eq 0 ];then
   echo "Current led status:$STATE"
else
   echo "Fialed to get led status."
   exit $FAILED
fi

echo 1 > /sys/class/gpio/gpio8/value

if [ $? -eq 0 ];then
   echo "led on."
else
   echo "Fialed to on led."
   exit $FAILED
fi

echo "Sleeping for 3 sec."
sleep 3;

echo $STATE > /sys/class/gpio/gpio8/value

if [ $? -eq 0 ];then
   echo "Restore previous status."
else
   echo "Fialed restore status."
   exit $FAILED
fi
exit $PASSED