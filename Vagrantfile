# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu22"
  config.vm.box_check_update = false

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "4096"
  end

  config.vm.define "wordpress" do |wordpress|
    wordpress.vm.hostname = "wordpress"
    wordpress.vm.provider "virtualbox" do |vb|
      vb.name = "wordpress"
    end
    wordpress.vm.network "private_network", ip: "192.168.33.100"
    wordpress.vm.provision "shell", path: "wordpress.sh"
  end

  config.vm.define "proxy" do |proxy|
    proxy.vm.hostname = "proxy"
    proxy.vm.provider "virtualbox" do |vb|
      vb.name = "proxy"
      vb.memory = "2048"
    end
    proxy.vm.network "private_network", ip: "192.168.33.101"
    proxy.vm.network "public_network", ip: "10.1.1.212", bridge: "en0: Ethernet"
    proxy.vm.provision "shell", path: "proxy.sh"
  end
end
