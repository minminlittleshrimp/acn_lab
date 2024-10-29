# PPPoE Setup Connection Guideline
First of all, configuring the server and the clients is necessary.
### PPPoE server - border(BRAS):
In the server (root@bng),
1.	Start configuring interfaces
```
bash /usr/local/bin/pppoe_server.sh 
```
2.	Check network interfaces
```
cat /etc/network/interfaces
```
Result:
```
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
```
3.	Check DNS server
```
cat /etc/resolve.conf
```
Result:
```
nameserver 8.8.8.8
nameserver 8.8.4.4
```
4. Check whether PPPoE server run on the interfaces
```
ps aux | grep pppoe
```  
Result: 
```
root         325  0.0  0.0   4396  1584 pts/1    S    04:56   0:00 pppoe-server -C isp1 -L 192.168.1.254 -p /etc/ppp/allip1 -I e1-1 -F
root         326  0.0  0.0   4396  1612 pts/1    S    04:56   0:00 pppoe-server -C isp2 -L 192.168.2.254 -p /etc/ppp/allip2 -I e1-2 -F
root         327  0.0  0.0   4396  1652 pts/1    S    04:56   0:00 pppoe-server -C isp3 -L 192.168.3.254 -p /etc/ppp/allip3 -I e1-3 -F
root         328  0.0  0.0   4396  1576 pts/1    S    04:56   0:00 pppoe-server -C isp4 -L 192.168.4.254 -p /etc/ppp/allip4 -I e1-4 -F
root         340  0.0  0.0   8884  1508 pts/1    S+   04:58   0:00 grep --color=auto pppoe
```
### PPPoE client - Home Gateway:
In one of the clients (root@gtw1),
1.	 Start configuring interfaces
```
bash /usr/local/bin/pppoe_client.sh
```
Result:
```
Configuration file created at /etc/ppp/peers/dsl_vgu with user: user1 and NIC: nic-e1-1
```
2. Initiate the PPPoE connection
```
pon dsl_vgu
```
Result: 
```
Plugin rp-pppoe.so loaded.
```

Once the configuration is complete, we need to test the connection whether it is good
### PPPoE Connection Test:
Before doing this, please find the inet address of the clients and the server
```
ifconfig
```
The information should be in "inet addr" of "ppp0"
Example:
```
ppp0      Link encap:Point-to-Point Protocol
          inet addr:192.168.1.1  P-t-P:192.168.1.254  Mask:255.255.255.255
          UP POINTOPOINT RUNNING NOARP MULTICAST  MTU:1492  Metric:1
          RX packets:34 errors:0 dropped:0 overruns:0 frame:0
          TX packets:27 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:3
          RX bytes:2285 (2.2 KB)  TX bytes:1628 (1.6 KB)
```
1. Set one side as listener with this command
```
nc -lkp 12345
```
2. On the other sides, send to the listener with the command
```
echo "<Message>"  | nc <listener's inet address> 12345
```
If the listener sees the message, that means the test is a success.
