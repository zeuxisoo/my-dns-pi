# My DNS Pi
 
A docker-compose file to provide set of service included a secure Pi-hole, monitoring and download services

## Usage

1. Clone the project to local
    
        git clone https://github.com/zeuxisoo/my-dns-pi.git

2. Enter to the project directory

        cd my-dns-pi

3. Edit the docker variable in `.env` file

        vim .env

4. Create and edit the AlertManager config file

        cp etc/alert-manager/conf/config.yml.example etc/alert-manager/conf/config.yml
        
        vim etc/alert-manager/conf/config.yml
        
5. Create and edit the DoT domain for caddy server

        cp etc/caddy/sites/dot.domain.conf.example etc/caddy/sites/your.domain.conf
        
        vim etc/caddy/sites/your.domain.conf
        
6. Create and edit the tls certification path in CoreDNS config file

        cp etc/coredns/Corefile.example etc/coredns/Corefile
        
        vim etc/coredns/Corefile
        
7. Create docker networks

        sudo docker network create caddy-net --subnet=172.28.240.0/24
        sudo docker network create pihole-net --subnet=172.28.241.0/24
        sudo docker network create monitor-net --subnet=172.28.242.0/24

8. Start the docker

        sudo docker up -d

9. If you don't set the pi dns in router or local network settings. You can edit your local host file hardcode the domain with pi ip

        sudo vim /etc/hosts

   Set the `pi.hole` to your pi ip address
   
        192.168.XXX.XXX pi.hole

10. Open the browser access the `https://pi.hole/`
11. Login and add the following address to `Local DNS Records`

    | Domain          | Pi IP Address   | Description  |
    |-----------------|-----------------| ------------ |
    | monitor.hole    | 192.168.XXX.XXX | Monitorix    |
    | prometheus.hole | 192.168.XXX.XXX | Prometheus   |
    | alert.hole      | 192.168.XXX.XXX | AlertManager |
    | grafana.hole    | 192.168.XXX.XXX | Granfana     |
    | aria2.hole      | 192.168.XXX.XXX | Aria2        |
    | file.hole       | 192.168.XXX.XXX | FileManager  |

## Other

Reload caddy server when add or edit or delete config

    sudo make caddy-reload

Remove the docker dangling image

    sudo docker images -f dangling=true
    sudo docker image prune

Remove all docker images

    sudo docker rmi $(sudo docker images -a -q)
