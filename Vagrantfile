# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|

  bridge = ENV['VAGRANT_BRIDGE']
  bridge ||= 'eth0'
  env  = ENV['PUPPET_ENV']
  env ||= 'dev'

  config.vm.define :freebsd do |freebsd|
    freebsd.vm.box = 'freebsd-10_puppet-3.6.2' 
    freebsd.vm.guest = :freebsd
    freebsd.vm.network :public_network, :bridge => bridge
    freebsd.vm.network "private_network", ip: "10.0.1.10"
    freebsd.vm.hostname = 'freebsd.local'

    freebsd.vm.provider :virtualbox do |vb|
	vb.customize ['modifyvm', :id, '--memory', 2048, '--cpus', 2]
    end

    freebsd.vm.synced_folder ".", "/vagrant", :nfs => true, id: "vagrant-root"
    freebsd.vm.provision "shell", inline: 'cd /vagrant && ./run.sh'
  end

update = <<SCRIPT
if [ ! -f /tmp/up ]; then
  sudo sed -i.bak s/us.archive/il.archive/g /etc/apt/sources.list
  sudo aptitude update 
  touch /tmp/up
fi
SCRIPT

  config.vm.define :ubuntu do |ubuntu|
    ubuntu.vm.hostname = 'ubuntu.local'
    ubuntu.vm.box = 'ubuntu-14.04_puppet-3.6.1'
    ubuntu.vm.network :public_network,  { bridge: 'eth0' }
    # ubuntu.vm.network :forwarded_port, guest: 8080, host: 8080
    ubuntu.vm.network :forwarded_port, guest: 55672, host: 55673
    ubuntu.vm.network :private_network, ip: "192.168.2.15"

    ubuntu.vm.provider :virtualbox do |vb|
	vb.customize ['modifyvm', :id, '--memory', 2048, '--cpus', 2]
    end

    ubuntu.vm.provision :shell, :inline => update
    ubuntu.vm.provision :puppet do |puppet|
	puppet.manifests_path = 'manifests'
	puppet.manifest_file  = 'default.pp'
	puppet.options = "--modulepath=/vagrant/modules:/vagrant/static-modules --hiera_config /vagrant/hiera_vagrant.yaml --environment=#{env}"
    end

  end


end
