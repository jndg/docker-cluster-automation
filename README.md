# Docker Cluster with SaltStack

This project automates the creation of a Docker cluster using Vagrant and SaltStack for infrastructure management.

## Features
- Automated cluster provisioning with Vagrant
- Configuration management with SaltStack
- Docker Swarm cluster setup
- Sample applications deployment

## Prerequisites
- Vagrant (v2.2+)
- VirtualBox or libvirt
- Git

## Quick Start

### 1. Clone the repository
```bash
git clone https://github.com/yourusername/docker-cluster.git
cd docker-cluster
```
### 2. Start the cluster
```bash
vagrant up
```
### 3. Configure SaltStack
```bash
vagrant ssh master
sudo salt-key -A -y  # Accept all minion keys
```

### 4. Deploy Docker to all nodes
```bash
sudo salt '*' state.apply docker
```
### 5. Initialize Docker Swarm
```bash
sudo salt 'master' cmd.run 'docker swarm init --advertise-addr 192.168.10.10'
sudo salt 'worker*' cmd.run 'docker swarm join --token <TOKEN> 192.168.10.10:2377'
```

# Customizing the Cluster

Edit these files to customize:

  ```Vagrantfile``` - Change node count, memory, or IP addresses

  ```/salt/docker/init.sls``` - Modify Docker configuration

  ```/salt/stack/web.sls``` - Add your own services
