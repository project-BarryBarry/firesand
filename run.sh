#!/bin/sh

# Run the application background
nohup /opt/AhnLab/ASTx/astxdaemon > /dev/null &
nohup /opt/anysign4pc/amd64/AnySign.ex > /dev/null &
sudo -u ubuntu nohup /opt/wizvera/veraport/veraport > /dev/null &


# Run haproxy
nohup haproxy -f /etc/haproxy/haproxy.cfg > /dev/null &

chown -R ubuntu:ubuntu /home/ubuntu/.config

apt install --fix-broken -y

/startup.sh