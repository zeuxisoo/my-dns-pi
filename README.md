# My DNS Pi

A docker-compose file to provide a set of service included a secure Pi-hole, monitoring, and download services

## Usage

1. Clone the project to local

    ```
    git clone https://github.com/zeuxisoo/my-dns-pi.git
    ```

2. Enter to the project directory

    ```
    cd my-dns-pi
    ```

3. Edit the docker variable in `.env` file

    ```
    vim .env
    ```

4. Change service related data permission

    ```
    sudo chown -Rf 65534:65534 etc/dnscrypt-proxy/config
    sudo chown -Rf 65534:65534 etc/prometheus/data
    sudo chown -Rf 65534:65534 etc/alert-manager/data
    sudo chown -Rf 472:472 etc/grafana/data
    ```

6. Setup config file for AlertManager

    Create the config file

    ```
    cp etc/alert-manager/conf/config.yml.example etc/alert-manager/conf/config.yml
    ```

    Edit the config file content

    ```
    vim etc/alert-manager/conf/config.yml     
    ```

6. Setup config file for DoT domain in Caddy server

    Create the config file

    ```
    cp etc/caddy/sites/dot.domain.conf.example etc/caddy/sites/your.domain.conf
    ```

    Edit the config file content

    ```
    vim etc/caddy/sites/your.domain.conf
    ```

7. Setup TLS certification path in CoreDNS config file

    Create the config file

    ```
    cp etc/coredns/Corefile.example etc/coredns/Corefile
    ```

    Edit the config file content
    
    ```
    vim etc/coredns/Corefile
    ```

8. Create docker networks

    ```
    sudo docker network create caddy-net --subnet=172.28.240.0/24
    sudo docker network create pihole-net --subnet=172.28.241.0/24
    sudo docker network create monitor-net --subnet=172.28.242.0/24
    ```

9. Start the docker
    
    ```
    sudo docker up -d
    ```

10. If you don't set the pi dns in router or local network settings. You can hardcode your domain in local `hosts` file the like

    Edit the `hosts` file

    ```
    sudo vim /etc/hosts
    ```

    Add the `pi.hole` domain to pi ip address
    
    ```
    192.168.XXX.XXX pi.hole
    ```

12. Open the browser access the `https://pi.hole/`

13. Login and add the following address to `Local DNS Records`

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
