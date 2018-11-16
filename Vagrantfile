# -*- mode: ruby -*-
# vi: set ft=ruby :
$script = <<-SCRIPT
# Install Docker from Ubuntu's repositories:
apt-get update
## Install prerequisites.
apt-get update && apt-get install -y apt-transport-https ca-certificates curl software-properties-common

## Download GPG key.
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

## Add docker apt repository.
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

## Install docker.
apt-get update && apt-get install -y docker-ce=18.06.0~ce~3-0~ubuntu

# Setup daemon.
cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

mkdir -p /etc/systemd/system/docker.service.d

# Restart docker.
systemctl daemon-reload
systemctl restart docker
modprobe overlay
modprobe br_netfilter

# Setup required sysctl params, these persist across reboots.
cat > /etc/sysctl.d/99-kubernetes-cri.conf <<EOF
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

sysctl --system
# Install prerequisites
apt-get update
apt-get install -y software-properties-common

add-apt-repository -y ppa:projectatomic/ppa
apt-get update

# Install CRI-O
apt-get install -y cri-o-1.12 podman
sudo mkdir -p /etc/containers
sudo curl https://raw.githubusercontent.com/projectatomic/registries/master/registries.fedora -o /etc/containers/registries.conf
sudo curl https://raw.githubusercontent.com/containers/skopeo/master/default-policy.json -o /etc/containers/policy.json
systemctl start crio


SCRIPT
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
  #if need bridge for vagrant
  #config.vm.network :public_network, :bridge => "en0: Ethernet"
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "4096"
  end
  config.vm.provision "shell", inline: $script

end
