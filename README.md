# My DNS Pi

Deploy my dns service into my raspberry pi 4B

## Create network

    sudo docker network create caddy-net --subnet=172.28.240.0/24
    sudo docker network create pihole-net --subnet=172.28.241.0/24
    sudo docker network create monitor-net --subnet=172.28.242.0/24

## Remove all docker images

    sudo docker rmi $(sudo docker images -a -q)
