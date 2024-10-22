Lab for VGU Master ITS ACN

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

