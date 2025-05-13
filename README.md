<<<<<<< HEAD
# docker-cluster-automation

my mini project

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

## Quick Start

### 1. Vagrant up
```bash
$ vagrant up
```
### 2. Configure SaltStack
```bash
$ vagrant ssh master
$ sudo salt-key -A -y  # Accept all worker keys
```

### 3. Deploy Docker to all workers
```bash
$ sudo salt '*' state.apply docker
```
### 4. Initialize Docker Swarm
```bash
$ docker swarm init --advertise-addr 192.168.10.10'
$ docker swarm join --token <copy your token>
```

# Customizing the Cluster

Edit these files to customize:

  ```Vagrantfile``` - Change node count, memory, or IP addresses

  ```/salt/docker/init.sls``` - Modify Docker configuration

  ```/salt/stack/web.sls``` - Add your own services
