FROM dorowu/ubuntu-desktop-lxde-vnc:focal
MAINTAINER BarryBarry <barrybarry.project@gmail.com>
USER root
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4EB27DB2A3B88B8B
RUN apt-get update && apt-get install -y \
    python3-pip \
    python3
RUN pip3 install --upgrade pip
COPY ./src /src
WORKDIR /
RUN pip3 install -r ./src/requirements.txt
RUN python3 ./src/main.py
USER ubuntu
EXPOSE 55921:55921
EXPOSE 4442:4442
EXPOSE 16105:16105
ENTRYPOINT ["/startup.sh"]