FROM dorowu/ubuntu-desktop-lxde-vnc:bionic
MAINTAINER BarryBarry <barrybarry.project@gmail.com>
USER root
RUN apt update && sudo apt install dirmngr -y
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4EB27DB2A3B88B8B
RUN apt update && apt upgrade -y && apt install -y python3-pip python3 apt-utils
RUN pip3 install --upgrade pip
WORKDIR /
COPY ./src /src
RUN pip3 install -r ./src/requirements.txt
# required dependency is missing
RUN apt install libssl1.0.0 -y

RUN mkdir -p "/home/ubuntu/.config/autostart"

RUN apt install --no-install-recommends software-properties-common -y
RUN add-apt-repository ppa:vbernat/haproxy-2.6 -y
RUN apt install haproxy -y
COPY ./haproxy.cfg /etc/haproxy/haproxy.cfg
RUN chmod 644 /etc/haproxy/haproxy.cfg
RUN chown root:root /etc/haproxy/haproxy.cfg

RUN python3 ./src/main.py

ENV USER=ubuntu
ENV PASSWORD=ubuntu

COPY ./run.sh /run.sh
RUN chmod +x /run.sh

ENTRYPOINT ["/run.sh"]