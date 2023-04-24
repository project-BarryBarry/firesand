#!/bin/sh
# Run the application background
sudo -u ubutu nohup /opt/wizvera/veraport/veraport &

touch /dev/mem

nohup /opt/AhnLab/ASTx/astxdaemon &

# Run haproxy
nohup haproxy -f /etc/haproxy/haproxy.cfg &

chown -R ubuntu:ubuntu /home/ubuntu/.config

/startup.sh