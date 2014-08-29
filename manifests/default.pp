group{ 'puppet': ensure  => present }

node 'freebsd.local' {

  $repos = {
    appliances  => {
      directory => '/home/vagrant/Syncthing',
      ro        => false,
      nodes     => []
    }
  }

  class{'backup::syncthing':
    repos => $repos
  }
}

node 'ubuntu.local' {

  $repos = {
    appliances  => {
      directory => '/home/vagrant/Syncthing',
      ro        => false,
      nodes     => []
    }
  }

  class{'backup::syncthing':
    repos => $repos
  }
}
