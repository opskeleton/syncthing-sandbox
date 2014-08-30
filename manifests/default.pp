group{ 'puppet': ensure  => present }

$nodes = {
    'C56YYFN-U7QEMMU-2J3DVM4-RFHHNAT-FH7ATN6-VJSREZY-XKYXPOF-RSKC7QE' => {name => 'foo' , address => 'foo:1234'},
}

node 'freebsd.local' {

  $repos = {
    appliances  => {
      directory => '/home/vagrant/Syncthing',
      ro        => false,
      nodes     => [
        'C56YYFN-U7QEMMU-2J3DVM4-RFHHNAT-FH7ATN6-VJSREZY-XKYXPOF-RSKC7QE',
      ]
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
      nodes     => [
        'C56YYFN-U7QEMMU-2J3DVM4-RFHHNAT-FH7ATN6-VJSREZY-XKYXPOF-RSKC7QE',
      ]

    }
  }

  class{'backup::syncthing':
    repos => $repos,
    nodes => $nodes
  }
}
