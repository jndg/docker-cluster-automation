# -*- mode: ruby -*-
# vi: set ft=ruby :

#This is a Vagrantfile created by Joonas Glad

$master_script = <<-MASTER_SCRIPT
set -o verbose
sudo apt-get update && sudo apt-get install -y curl ca-certificates
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://packages.broadcom.com/artifactory/api/security/keypair/SaltProjectKey/public | sudo tee /etc/apt/keyrings/salt-archive-keyring.pgp
curl -fsSL https://github.com/saltstack/salt-install-guide/releases/latest/download/salt.sources | sudo tee /etc/apt/sources.list.d/salt.sources
sudo apt-get update
sudo apt-get install -y salt-master
sudo systemctl enable salt-master && sudo systemctl restart salt-master.service
MASTER_SCRIPT

$minion_script = <<-MINION_SCRIPT
set -o verbose

#Install Salt Minion
sudo apt-get update && sudo apt-get install -y curl ca-certificates
sudo mkdir -p /etc/apt/keyrings
sudo curl -fsSL https://packages.broadcom.com/artifactory/api/security/keypair/SaltProjectKey/public | sudo tee /etc/apt/keyrings/salt-archive-keyring.pgp
sudo curl -fsSL https://github.com/saltstack/salt-install-guide/releases/latest/download/salt.sources | sudo tee /etc/apt/sources.list.d/salt.sources
sudo apt-get update
sudo apt-get install -y salt-minion
echo "master: 192.168.10.10" | sudo tee /etc/salt/minion.d/master.conf
sudo systemctl restart salt-minion.service

# Install Docker prerequisites and repository
sudo apt-get update
sudo apt-get install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add Docker repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

MINION_SCRIPT

Vagrant.configure("2") do |config|
	config.vm.synced_folder "salt/", "/srv/salt"
	config.vm.synced_folder "shared/", "/home/vagrant/shared", create: true
	config.vm.define "master" do |master|
	  master.vm.box = "debian/bullseye64"
	  master.vm.box_version = "11.20241217.1"
	  master.vm.provision :shell, inline: $master_script
	  master.vm.network "private_network", ip: "192.168.10.10"
	  master.vm.hostname = "master"
	end
	
	(1..2).each do |i|
	config.vm.define "worker#{i}" do |worker|
	  worker.vm.box = "generic/debian12"
	  worker.vm.provision :shell, inline: $minion_script
	  worker.vm.network "private_network", ip: "192.168.10.#{10 + i}"
	  worker.vm.hostname = "worker#{i}"
	 end
	end

end
