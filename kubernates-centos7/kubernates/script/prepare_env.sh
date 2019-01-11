#!/usr/bin/env bash
systemctl stop firewalld
systemctl disable firewalld
sed -i "s#SELINUX=enforcing#SELINUX=disabled#g" /etc/sysconfig/selinux