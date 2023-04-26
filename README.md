# firesand
[![Docker](https://github.com/project-BarryBarry/firesand/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/project-BarryBarry/firesand/actions/workflows/docker-publish.yml)

runing all secure programs in docker

**Currently works only in Chromium**

![image](https://user-images.githubusercontent.com/24631476/234180310-6e146c26-7b61-4ec2-9a68-9c3099428c6a.png)

This is for when security programs do not install due to dependency issues like this.

## Getting Started
Before starting, you need to install [docker](https://docs.docker.com/engine/install/) and [docker-compose](https://docs.docker.com/compose/install/).

Start the container by running the following command:

```
wget https://raw.githubusercontent.com/project-BarryBarry/firesand/main/docker-compose.yml -O docker-compose.yml
docker-compose up -d
```
You can access the container at [here](http://127.0.0.1:6080).

Run the security program you need from 'Menu → Other'.

If you don't have the programs you need, most Web sites will automatically try to install them when you run Veraport.

Your browser should always trust localhost's ssl certificate.

Follow these steps to make Chromium trust localhost's certificate:
1. Paste `chrome://flags/#allow-insecure-localhost` into the address bar.
2. Press Enter.
3. Change the value to Enabled.

## How this works?
1. First, forward the port of the security program bound to the local host to 0.0.0.0 through haproxy.
2. Forward the container's port to the host's localhost in the docker-compose.yml file.

## Troubleshooting
1. The security program was installed automatically, but it doesn't work.<br>
Probably, it seems that the security program communicates with the website through the port, not just checking whether it is installed or not.<br>
You can expose ports by editing `/etc/haproxy/haproxy.cfg` and `docker-compose.yml`. <br>
If you leave an issue, we will include it in the container.
