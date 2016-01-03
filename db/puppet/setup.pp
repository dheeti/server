class { 'java':
    distribution => 'jre',
}

class { 'neo4j':
    require                     => Class['java'],
    version                     => '2.3.1',
    edition                     => 'community',
    install_prefix              => '/opt/neo4j',
    jvm_init_memory             => '128',
    jvm_max_memory              => '128',
    allow_remote_connections    => true,
    address                	    => '0.0.0.0',
}

class {'python': }

ssh-user { "admin":
    username    => "admin",
    pub_key     => "puppet:///modules/users/authorized_keys",
}
