# ruTorrent/rTorrent

## Requirements

* Docker

## Features
* Based on Alpine Linux.
* Provides by default a solid configuration.
* No **ROOT** process.
* Add your own plugins and themes

## Description
What is [RuTorrent](https://github.com/Novik/ruTorrent) ?

ruTorrent is a front-end for the popular Bittorrent client rtorrent.
This project is released under the GPLv3 license, for more details, take a look at the LICENSE.md file in the source.

What is [rtorrent](https://github.com/rakshasa/rtorrent/) ?

rtorrent is the popular Bittorrent client.

**This image not contains root process**

### Build

```sh
docker build -t docker-torrent .
mkdir -p /homez/docker/docker-torrent/{rtorrent,var/log}
```

### Launch

Run container :

```sh
docker run -idt \
    -p 45566:45566 \
    -e UID=1001 \
    -e GID=1001 \
    -v /homez/docker/docker-torrent/rtorrent/:/rtorrent \
    -v /homez/docker/docker-torrent/var/log:/var/log \
    --dns 84.200.69.80 \
    --restart always docker-torrent
```

URI access : http://xx.xx.xx.xx:8080/

### Additional commands to run locally

If iptables blocks output traffic on your PC, allow traffic to the port `8080` in the docker network `172.17.0.0/16`

```sh
iptables -A OUTPUT -p tcp --dport 8080 -d 172.17.0.0/16 -m state --state NEW,ESTABLISHED -j ACCEPT
```
