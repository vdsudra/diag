TIMESTAMP=`date +"[%a %b        %e %H:%M:%S %Y]"`
LOGPATH="/home/santoshm/work/application/diag/diag_logs"
# Checking SD card is connection
echo -e "Testing USB.....\n"
TIMESTAMP="$TIMESTAMP : Testing USB....."
echo $TIMESTAMP >> $LOGPATH
#echo `$TIMESTAMP" Testing USB....." >> $LOGPATH`
USB_DEVICE=`lsblk -l | grep "sd.1"`
if [ $? -ne 0 ];
then
   echo "Fail to find device."
   exit $RET
fi


