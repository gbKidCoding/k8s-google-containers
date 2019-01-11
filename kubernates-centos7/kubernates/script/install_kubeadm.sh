#!/usr/bin/env bash
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=http://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=0
repo_gpgcheck=0
gpgkey=http://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg
       http://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF
setenforce 0
yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
systemctl enable kubelet && systemctl start kubelet

docker pull mooncakexyb/kube-apiserver-amd64:v1.13.0
docker pull mooncakexyb/kube-controller-manager-amd64:v1.13.0
docker pull mooncakexyb/kube-scheduler-amd64:v1.13.0
docker pull mooncakexyb/kube-proxy-amd64:v1.13.0
docker pull mooncakexyb/pause:3.1
docker pull mooncakexyb/etcd-amd64:3.2.24
docker pull mooncakexyb/coredns:1.2.6
docker pull mooncakexyb/kubernetes-dashboard-amd64:v1.10.0
docker pull cnych/flannel:v0.10.0-amd64


docker tag mooncakexyb/kube-apiserver-amd64:v1.13.0 k8s.gcr.io/kube-apiserver:v1.13.0
docker tag mooncakexyb/kube-controller-manager-amd64:v1.13.0 k8s.gcr.io/kube-controller-manager:v1.13.0
docker tag mooncakexyb/kube-scheduler-amd64:v1.13.0 k8s.gcr.io/kube-scheduler:v1.13.0
docker tag mooncakexyb/kube-proxy-amd64:v1.13.0 k8s.gcr.io/kube-proxy:v1.13.0
docker tag mooncakexyb/pause:3.1 k8s.gcr.io/pause:3.1
docker tag mooncakexyb/etcd-amd64:3.2.24 k8s.gcr.io/etcd:3.2.24
docker tag mooncakexyb/coredns:1.2.6 k8s.gcr.io/coredns:1.2.6
docker tag mooncakexyb/kubernetes-dashboard-amd64:v1.10.0 k8s.gcr.io/kubernetes-dashboard-amd64:v1.10.0
docker tag cnych/flannel:v0.10.0-amd64 quay.io/coreos/flannel:v0.10.0-amd64

swapoff -a
echo 1 > /proc/sys/net/bridge/bridge-nf-call-iptables
echo 1 > /proc/sys/net/bridge/bridge-nf-call-ip6tables

kubeadm init --kubernetes-version=1.13.0 --pod-network-cidr=10.244.0.0/16

export KUBECONFIG=/etc/kubernetes/admin.conf
echo "export KUBECONFIG=/etc/kubernetes/admin.conf" >> ~/.bash_profile

kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/v0.10.0/Documentation/kube-flannel.yml