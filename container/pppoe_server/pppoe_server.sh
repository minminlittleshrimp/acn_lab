#!/bin/bash

# Network configuration
cat <<EOL > /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth2
iface eth2 inet static
address 192.168.1.254
netmask 255.255.255.0
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
user1       *    pass1       *
user2       *    pass2       *
EOL

# ip range
cat <<EOL > /etc/ppp/allip
192.168.1.1-50
EOL

# pppoe server
#pppoe-server -I eth1 -F
#pppoe-server -C isp -L 192.168.1.254 -p /etc/ppp/allip -I eth2 -F

# Set up IP forwarding
#echo 1 > /proc/sys/net/ipv4/ip_forward
#iptables -t nat -A POSTROUTING -s 192.168.1.0/24 -o eth1 -j MASQUERADE
