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

  %w(ubuntu monitor).each do |host|
    config.vm.define host.to_sym do |node|
	node.vm.hostname = "#{host}.local"
	node.vm.box = 'ubuntu-14.04_puppet-3.6.1'
	node.vm.network :public_network,  { bridge: 'eth0' }

	node.vm.provider :virtualbox do |vb|
	  vb.customize ['modifyvm', :id, '--memory', 2048, '--cpus', 2]
	end

	node.vm.provision :shell, :inline => update
	node.vm.provision :puppet do |puppet|
	  puppet.manifests_path = 'manifests'
	  puppet.manifest_file  = "#{host}.pp"
	  puppet.options = "--modulepath=/vagrant/modules:/vagrant/static-modules --hiera_config /vagrant/hiera_vagrant.yaml --environment=#{env}"
	end

    end
  end


end
