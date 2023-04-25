#!/bin/sh
# Run the application background
sudo -u ubuntu nohup /opt/wizvera/veraport/veraport &

touch /dev/mem

nohup /opt/AhnLab/ASTx/astxdaemon &

nohup /opt/INITECH/crosswebex/INISAFECrossWebEXSvc &

# Run haproxy
nohup haproxy -f /etc/haproxy/haproxy.cfg &

chown -R ubuntu:ubuntu /home/ubuntu/.config

/startup.sh