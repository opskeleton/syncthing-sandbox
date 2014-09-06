group{ 'puppet': ensure  => present }

$nodes = {
  'C56YYFN-U7QEMMU-2J3DVM4-RFHHNAT-FH7ATN6-VJSREZY-XKYXPOF-RSKC7QE' => {name => 'foo' , address => 'foo:1234'},
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

  class { 'sensu':
    rabbitmq_password    => 'secret',
    rabbitmq_host        => '10.0.2.2',
    rabbitmq_port        => '55672',
    rabbitmq_vhost       => '/sensu',
    subscriptions        => 'syncthing',
    sensu_plugin_version => 'latest'
  }
}
