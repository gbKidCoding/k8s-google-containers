#!/usr/bin/env bash
systemctl stop firewalld
systemctl disable firewalld
swapoff -a
echo 1 > /proc/sys/net/bridge/bridge-nf-call-iptables
echo 1 > /proc/sys/net/bridge/bridge-nf-call-ip6tables
sed -i "s#SELINUX=enforcing#SELINUX=disabled#g" /etc/sysconfig/selinux