# Lab project for VGU Master ITS ACN
This is the project of our group using PPPoE to design and build a telecommunication network. <br>
PPPoE is widely used by ISPs to manage customer connections, providing authentication, encryption, and dynamic IP address assignment over Ethernet networks. Our goal is to configure a functional network that allows subscribing clients to the network and let them gain access and use the services.

### Conditions
This network shall initially offer these functions:
+ Homegateway device, as perimeter between the home network and the telecommunication network.
+ Broadband Network Gateway (BNG)
+ Access only for registered users
+ Basic ability to account the traffic of each user
+ Clear separation of user traffic
+ Ability for local DNS name resolution

There are some restrictions for this such as:
+ Only a single IPv4 address can be assigned to each customer's home
+ A full /56  IPv6 prefix can be assigned to each customer's home



### Commands for building docker image and deploying Containerlab
Build docker image:
```
# docker build -t acnlab .
```

Build docker image with proxy:
```
# sudo docker build --build-arg HTTP_PROXY="http://127.0.0.1:3128" --build-arg HTTPS_PROXY="http://127.0.0.1:3128" --network=host -t acnlab .
```

Containerlab deploy:
```
# sudo containerlab deploy topo/topology.yml
```

Reconfigure only:
```
# sudo containerlab deploy topo/topology.yml --reconfigure
```

