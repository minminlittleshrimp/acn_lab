#!/bin/bash

# Network configuration
cat <<EOL > /etc/network/interfaces
auto lo
iface lo inet loopback

auto e1-1
iface e1-1 inet static
	address 20.20.20.1/24

auto e1-2
iface e1-2 inet static
	address 20.20.20.2/24

auto e1-3
iface e1-3 inet static
	address 20.20.20.3/24

auto e1-4
iface e1-4 inet static
	address 20.20.20.4/24
EOL

# DNS server
cat <<EOL > /etc/resolve.conf
nameserver 8.8.8.8
nameserver 8.8.4.4
EOL

# PPPoE server configuration
cat <<EOL > /etc/ppp/pppoe-server-options
debug
require-pap
mtu 1492
mru 1492
ktune
proxyarp
lcp-echo-interval 10
lcp-echo-failure 2
nobsdcomp
noccp
novj
noipx
EOL

# pap setup
cat <<EOL > /etc/ppp/pap-secrets
"user1" 	*	"pass1"     *
"user2" 	*	"pass2"	    *
"user3" 	*	"pass3"	    *
"user4" 	*	"pass4"	    *
EOL

# ip range
cat <<EOL > /etc/ppp/allip1
20.20.20.11-19
EOL

cat <<EOL > /etc/ppp/allip2
20.20.20.20-29
EOL
cat <<EOL > /etc/ppp/allip3
20.20.20.30-39
EOL

cat <<EOL > /etc/ppp/allip4
20.20.20.40-49
EOL

# Set up IP forwarding
echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -t nat -A POSTROUTING -s 20.20.20.0/24 -o eth0 -j MASQUERADE

# Restart networking
/etc/init.d/networking stop
/etc/init.d/networking start

# PPPoE Server
pppoe-server -C isp1 -L 20.20.20.1 -p /etc/ppp/allip1 -I e1-1 -F &
pppoe-server -C isp2 -L 20.20.20.2 -p /etc/ppp/allip2 -I e1-2 -F &
pppoe-server -C isp3 -L 20.20.20.3 -p /etc/ppp/allip3 -I e1-3 -F &
pppoe-server -C isp4 -L 20.20.20.4 -p /etc/ppp/allip4 -I e1-4 -F &

# DNS
cat <<EOL > /etc/dnsmasq.conf
interface=pppoe0
listen-address=20.20.20.100
address=/www.vgu_acn.com/20.20.20.100
dhcp-range=20.20.20.50,20.20.20.99,12h
EOL