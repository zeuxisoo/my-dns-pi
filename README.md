# My DNS Pi

A docker-compose file to provide a set of service included AdGuard Home and other services

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

    If you want to find the current user id

    ```
    id username
    ```
4. Setup config file for DoT domain in Caddy server

    Create the config file

    ```
    cp etc/caddy/sites/dot.domain.conf.example etc/caddy/sites/your.domain.conf
    ```

    Edit the config file content

    ```
    vim etc/caddy/sites/your.domain.conf
    ```

5. Create docker networks

    ```
    sudo docker network create caddy-net --subnet=172.28.240.0/24
    sudo docker network create adguard-home-net --subnet=172.28.241.0/24
    ```

6. Start the docker

    ```
    sudo docker-compose up -d
    ```

7. If you don't set the pi dns in router or local network settings. You can hardcode your domain in local `hosts` file the like

    Edit the `hosts` file

    ```
    sudo vim /etc/hosts
    ```

    Add the `pi.hole` domain to pi ip address

    ```
    192.168.XXX.XXX pi.hole
    ```

8. Open the browser access the `https://pi.hole/`

9. Login and add the following address to `Local DNS Records`

    | Domain          | Pi IP Address   | Description  |
    |-----------------|-----------------| ------------ |
    | pi.hole         | 192.168.XXX.XXX | AdGuard Home |

## Other

Reload caddy server when add or edit or delete config

    sudo make caddy-reload

Remove the docker dangling image

    sudo docker images -f dangling=true
    sudo docker image prune

Remove all docker images

    sudo docker rmi $(sudo docker images -a -q)
