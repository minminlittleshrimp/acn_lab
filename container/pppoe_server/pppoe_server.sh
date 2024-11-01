#!/bin/bash

# Network configuration
cat <<EOL > /etc/network/interfaces
auto lo
iface lo inet loopback

auto e1-1
iface e1-1 inet static
	address 192.168.1.254/24

auto e1-2
iface e1-2 inet static
	address 192.168.2.254/24

auto e1-3
iface e1-3 inet static
	address 192.168.3.254/24

auto e1-4
iface e1-4 inet static
	address 192.168.4.254/24
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
192.168.1.1-50
EOL

cat <<EOL > /etc/ppp/allip2
192.168.2.1-50
EOL
cat <<EOL > /etc/ppp/allip3
192.168.3.1-50
EOL

cat <<EOL > /etc/ppp/allip4
192.168.4.1-50
EOL

# Set up IP forwarding
echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -t nat -A POSTROUTING -s 192.168.1.0/24 -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 192.168.2.0/24 -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 192.168.3.0/24 -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 192.168.4.0/24 -o eth0 -j MASQUERADE

# Restart networking
/etc/init.d/networking stop
/etc/init.d/networking start

# PPPoE Server
pppoe-server -C isp1 -L 192.168.1.254 -p /etc/ppp/allip1 -I e1-1 -F &
pppoe-server -C isp2 -L 192.168.2.254 -p /etc/ppp/allip2 -I e1-2 -F &
pppoe-server -C isp3 -L 192.168.3.254 -p /etc/ppp/allip3 -I e1-3 -F &
pppoe-server -C isp4 -L 192.168.4.254 -p /etc/ppp/allip4 -I e1-4 -F &
