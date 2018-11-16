# Vagrant cri-o box
Example for running [cri-o](https://github.com/kubernetes-sigs/cri-o) in vagrant based on Ubuntu bionic

### What for?
The problem was, I want to tests cri-o in Macos, but it is impossible.
For resolving this issue I wrote simple Vagrantfile for up and running cri-o inside vagrant and sending command from host machine to vagrant box.

### How to use
clone repository
```bash
git clone git@github.com:pyToshka/vagrant-crio.git
```

Change directory

```bash
cd vagrant-crio
```
If need bridge for Vagrant box you should uncommented line 68 in Vagrantfile

More about Vagrant networking you can fine on official [Vagrant site](https://www.vagrantup.com/docs/networking/public_network.html)
```bash
  config.vm.network :public_network, :bridge => "en0: Ethernet"

```

### Simple using

After up and running, you can use simple script to sending command to cri-o inside vagrant.
Example:

```bash
cd vagrant-crio
chmod +x vagrant-crio.sh
./vagrant-crio.sh "podman images"

```

Output

```bash
REPOSITORY                  TAG      IMAGE ID       CREATED       SIZE
docker.io/library/busybox   latest   59788edf1f3e   6 weeks ago   1.37 MB

```

Any commands should has format

```bash
./vagrant-crio.sh "comand which you want to run inside vagrant box"
```


Have a fun time with cri-o and vagrant