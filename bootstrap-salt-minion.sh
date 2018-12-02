#!/bin/sh
echo "@@@ starting setup up salt-minion"
# use the latest stable Salt from repo.saltstack.com
yum install https://repo.saltstack.com/yum/redhat/salt-repo-latest-2.el7.noarch.rpm  -y
sudo yum clean expire-cache -y
sudo yum update -y
sudo yum install salt-minion -y
#sudo service salt-minion restart || true
# setup top files to test the formula
#sudo ln -s /srv/salt/pillar.example /srv/pillar/salt.sls
#sudo ln -s /srv/salt/dev/pillar_top.sls /srv/pillar/top.sls
# this file will be copied to make a running config. it should not be checked in.
#sudo cp /srv/salt/dev/state_top.sls /srv/salt/top.sls
# Accept all keys#
#sleep 15 #give the minion a few seconds to register
#sudo salt-key -y -A
echo "@@@ finished setup salt-minion"
