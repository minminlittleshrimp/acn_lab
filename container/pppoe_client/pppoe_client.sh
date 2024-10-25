#!/bin/bash

# pppoe.conf
cat <<EOL > /etc/ppp/pppoe.conf
ETH=eth1
USER=user1 #user delcarared from pap in server 
DEMAND=no
DNSTYPE=SERVER
PEERDNS=yes
DNS1=8.8.8.8
DNS2=8.8.4.4
DEFAULTROUTE=yes
CONNECT_TIMEOUT=30
CONNECT_POLL=2
ACNAME=
SERVICENAME=
PING="."
CF_BASE=`basename $CONFIG`
PIDFILE="/var/run/$CF_BASE-pppoe.pid"
SYNCHRONOUS=no
CLAMPMSS=1412
LCP_INTERVAL=20
LCP_FAILURE=3
PPPOE_TIMEOUT=80
FIREWALL=NONE
PPPOE_EXTRA=""
PPPD_EXTRA=""
EOL

# client pppoe
# pppoe-start -I eth1 user1
