
node 'monitor.local' {

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
    nodes => $nodes,
    token => 'mhfu4ugmsauj6cgvsu68kvloa1gt3v'
  }

  include monitoring

  class{'monitoring::syncthing':
    token => 'mhfu4ugmsauj6cgvsu68kvloa1gt3v'
  }
}
