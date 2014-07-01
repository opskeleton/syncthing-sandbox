group{ 'puppet': ensure  => present }

node 'syncthing.local' {

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
