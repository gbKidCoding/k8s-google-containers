#!/usr/bin/env bash

systemctl stop firewalld
systemctl disable firewalld
sed -i "s#SELINUX=enforcing#SELINUX=disabled#g" /etc/sysconfig/selinux

sudo yum install -y vim
sudo yum install -y git
sudo yum install -y wget
sudo yum install -y bash-completion

wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo

yum makecache