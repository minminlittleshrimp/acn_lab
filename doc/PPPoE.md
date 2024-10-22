# Setup pppoe connection

### PPPoE server - border(BRAS):

1. Server-side setup:

```
root@border:~# cat << EOF > /etc/ppp/options
> noauth
> ms-dns 8.8.8.8
> ms-dns 8.8.4.4
> mtu 1492
> mtu 1492
> EOF
```

2. Server start in range:

```
root@border:~# sudo pppoe-server -I e1-1 -L 192.168.1.1 -R 192.168.1.10 -N 10
```

### PPPoE client - Home Gateway:

1. Client configuration:

```
root@homegateway:~# cat << EOF > /etc/ppp/peers/dsl-provider
> plugin rp-pppoe.so e1-1
> user "client"
> noipdefault
> defaultroute
> replacedefaultroute
> hide-password
> persist
> lcp-echo-interval 30
> lcp-echo-failure 5
> EOF
```

2. Client authentication:

```
root@homegateway:~# cat << EOF > /etc/ppp/chap-secrets
> "hgw" *            "hgw" *
> EOF
```

### PPPoE test connection:

1. Client start PPPoE connection:

```
root@homegateway:~# pppd call dsl-provider
```

2. Verify PPP interface:

```
root@homegateway:~# ifconfig ppp0
```

3. Ping to server/google:

```
root@homegateway:~# ping -I ppp0 192.168.1.1
root@homegateway:~# ping -I ppp0 8.8.8.8
```

4. Send some packets/messages:

4.1. Border:

```
root@border:~# nc -l -p 12345
```

4.2. Home Gateway:

```
root@homegateway:~# echo "Hello from PPPoE client" | nc 192.168.1.1 12345
```

5. Further checking:

5.1. Ensure the default route is set to ppp0:

```
root@homegateway:~# ip route
```

5.2. tbd

