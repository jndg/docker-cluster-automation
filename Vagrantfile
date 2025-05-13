# -*- mode: ruby -*-
# vi: set ft=ruby :


$master_script = <<-MASTER_SCRIPT
set -o verbose

#Install Salt Master
sudo apt-get update && sudo apt-get install -y curl ca-certificates
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://packages.broadcom.com/artifactory/api/security/keypair/SaltProjectKey/public | sudo tee /etc/apt/keyrings/salt-archive-keyring.pgp
curl -fsSL https://github.com/saltstack/salt-install-guide/releases/latest/download/salt.sources | sudo tee /etc/apt/sources.list.d/salt.sources
sudo apt-get update
sudo apt-get install -y salt-master
sudo systemctl enable salt-master && sudo systemctl start salt-master.service


MASTER_SCRIPT

$worker_script = <<-WORKER_SCRIPT
set -o verbose

# Install Salt Minion
sudo apt-get update && sudo apt-get install -y curl ca-certificates
sudo mkdir -p /etc/apt/keyrings
sudo curl -fsSL https://packages.broadcom.com/artifactory/api/security/keypair/SaltProjectKey/public | sudo tee /etc/apt/keyrings/salt-archive-keyring.pgp
sudo curl -fsSL https://github.com/saltstack/salt-install-guide/releases/latest/download/salt.sources | sudo tee /etc/apt/sources.list.d/salt.sources
sudo apt-get update
sudo apt-get install -y salt-minion
echo "master: 192.168.10.10" | sudo tee /etc/salt/minion.d/master.conf
sudo systemctl restart salt-minion


WORKER_SCRIPT

Vagrant.configure("2") do |config|

 config.vm.provider "virtualbox" do |vb|
    vb.memory = 4096
    vb.cpus = 4
  end


  config.vm.box = "debian/bookworm64"
  
  config.vm.synced_folder "salt/", "/srv/salt"
  
config.vm.define "master" do |master|
    master.vm.provision :shell, inline: $master_script
    master.vm.network "private_network", ip: "192.168.10.10"
    master.vm.hostname = "master"
      
  end
  
  (1..2).each do |i|
    config.vm.define "worker#{i}" do |worker|
      worker.vm.provision :shell, inline: $worker_script
      worker.vm.network "private_network", ip: "192.168.10.#{10 + i}"
      worker.vm.hostname = "worker#{i}"
      
    end

  end
end
