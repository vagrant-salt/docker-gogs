#!/bin/bash
fqdn=$1
proxyUrl=$2

echo "@@@ starting bootstrap computer: $fqdn"
sudo echo "$fqdn" > /etc/hostname
sudo echo "HOSTNAME=$fqdn" >> /etc/sysconfig/network
sudo hostname $fqdn
sudo service NetworkManager restart
if [[ "$proxyUrl" ]]; then
    sudo echo "proxy=http://gateway.bns:8000" >> /etc/yum.conf
fi
sudo yum install epel-release -y
sudo yum update -y
sudo yum install git -y
if [[ "$proxyUrl" ]]; then
    sudo git config --global http.proxy http://gateway.bns:8000
fi
sudo sed -i /etc/selinux/config -r -e 's/^SELINUX=.*/SELINUX=disabled/g'
echo "@@@ finished bootstrap computer: $fqdn"
