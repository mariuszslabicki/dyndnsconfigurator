#!/bin/bash

UPDATEURL="http://freedns.afraid.org/dynamic/update.php?YOURAPIKEYHERE"

#check if the file with ip exists
if [ -e ip_last.tmp ]
then 
	#if yes, read old ip addr
	read -r OLD_IP<ip_last.tmp
else
	#if no set old ip addr as null
	OLD_IP=""
fi

#read external ip
EXTERNAL_IP=`wget -q -O - checkip.dyndns.org | sed -e 's/[^[:digit:]\|.]//g'`

#check if the old ip equals just readed ip addr
if [ "$OLD_IP" == "$EXTERNAL_IP" ]; then
	#if yes, exit
	exit 0
fi

#save external ip to file
echo $EXTERNAL_IP > ip_last.tmp

#make a request for update
wget -q -O /dev/null $UPDATEURL
