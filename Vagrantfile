# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|

  bridge = ENV['VAGRANT_BRIDGE']
  bridge ||= 'eth0'
  env  = ENV['PUPPET_ENV']
  env ||= 'dev'

  config.vm.box = 'freebsd-10_puppet-3.6.2' 
  config.vm.guest = :freebsd
  config.vm.network :public_network, :bridge => bridge
  config.vm.network "private_network", ip: "10.0.1.10"
  config.vm.hostname = 'syncthing.local'

  config.vm.provider :virtualbox do |vb|
    vb.customize ['modifyvm', :id, '--memory', 2048, '--cpus', 2]
  end

  config.vm.synced_folder ".", "/vagrant", :nfs => true, id: "vagrant-root"
  config.vm.provision "shell", inline: 'cd /vagrant && ./run.sh'
end
