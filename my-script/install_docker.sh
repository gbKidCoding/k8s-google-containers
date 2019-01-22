#!/usr/bin/env bash

yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2
yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

yum -y install docker-ce-18.06.1.ce-3.el7
curl -sSL https://get.daocloud.io/daotools/set_mirror.sh | sh -s http://e7850958.m.daocloud.io
systemctl enable docker
systemctl restart docker
service docker restart
