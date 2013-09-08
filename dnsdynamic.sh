#!/bin/bash
#check if the file with old ip exist
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
#username used in www.dnsdynamic.org -- @ changed for %40
USER="username%40domain.net"
#password used
PASSWD="simplepasswd"
#hostname configured in www.dnsdynamic.org, below is just example
HOSTNAME='exampledomain.flashserv.net'
#whole request
REQUEST="https://$USER:$PASSWD@www.dnsdynamic.org/api/?hostname=$HOSTNAME&myip=$EXTERNAL_IP"
wget -qO /dev/null $REQUEST
