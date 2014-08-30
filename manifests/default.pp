group{ 'puppet': ensure  => present }

$nodes = {
    '1' => {name => 'foo' , address => 'foo:1234'},
    '2' => {name => 'bar', address   => 'bar:22000'}
}

node 'freebsd.local' {

  $repos = {
    appliances  => {
      directory => '/home/vagrant/Syncthing',
      ro        => false,
      nodes     => ['1', '2']
    }
  }

  class{'backup::syncthing':
    repos => $repos,
    nodes => $nodes
  }
}

node 'ubuntu.local' {

  $repos = {
    appliances  => {
      directory => '/home/vagrant/Syncthing',
      ro        => false,
      nodes     => ['1', '2']
    }
  }

  class{'backup::syncthing':
    repos => $repos,
    nodes => $nodes
  }
}
