#!/usr/bin/bash

cp /etc/hosts /etc/hosts_old
rm -f /tmp/tmp_hosts
awk '!/homebox/ && !/120s/' /etc/hosts > /tmp/tmp_hosts && mv /tmp/tmp_hosts /etc/hosts

# the 'raw file' on github is not updated properly.
#echo `curl -s https://raw.githubusercontent.com/crtoled/ip-public/main/ip.txt | tail -n1` 'homebox'  >> /etc/hosts

git clone https://github.com/crtoled/ip-public.git /tmp/homebox
#echo `cat /tmp/homebox/ip.txt | tail -n1` 'homebox'  >> /etc/hosts
IPADDRESSES=(`cat /tmp/homebox/ip-box2022.txt | tail -n1`)
IP=`echo ${IPADDRESSES[0]} '   homebox' | grep -v '^192.168\|^10'`  # Exclude the internal IPs.
echo $IP >> /etc/hosts

if [ ! -z "${IPADDRESSES[1]}" ]; then
    IP=`echo ${IPADDRESSES[1]} 'homebox' | grep -v '^192.168\|^10'`  # Exclude the internal IPs.
    echo -n $IP >> /etc/hosts
fi

#echo `cat /tmp/homebox/ip-box2022.txt | tail -n1` '     homebox'  >> /etc/hosts
#echo `cat /tmp/homebox/ip-120s.txt | tail -n1` '     120s'  >> /etc/hosts

tail -2 /etc/hosts

rm -rf /tmp/homebox
