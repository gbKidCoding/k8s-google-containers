#!/usr/bin/env bash
## install pip
sudo yum install python-devel
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py
sudo pip install docker-compose
sudo curl -L https://raw.githubusercontent.com/docker/compose/1.23.2/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose
