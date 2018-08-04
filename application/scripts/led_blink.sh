#!/bin/bash

# File      : led_blink.sh
# brief     : Script to blink diag LED

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


COUNT=0

while [ $COUNT -lt 5 ]
do
   COUNT=`expr $COUNT + 1`
   echo 1 > /sys/class/gpio/gpio8/value

   if [ $? -eq 0 ];then
       echo "led on."
   else
       echo "Failed to on led."
       exit $FAILED
   fi
   sleep 0.3
   echo 0 > /sys/class/gpio/gpio8/value
   if [ $? -eq 0 ];then
       echo "led off."
   else
       echo "Failed to off led."
       exit $FAILED
   fi
   sleep 0.3
done

echo $STATE > /sys/class/gpio/gpio8/value

if [ $? -eq 0 ];then
   echo "Restore previous status."
else
   echo "Failed restore status."
   exit $FAILED
fi
exit $PASSED

