class { 'java':
  distribution => 'jre',
}

class { 'neo4j' :
    require => Class['java'],
    jvm_init_memory => '128',
    jvm_max_memory  => '128',
}

class { 'packages' : }

class { 'users' :
    require => Class['packages'],
}

vcsrepo { '/home/node-user/churchill':
    require  => Class['users'],
    ensure   => present,
    provider => git,
    source   => 'https://github.com/psu-capstone/churchill.git',
    revision => 'ryan_prelim',
    owner    => 'node-user',
    group    => 'node-user',
}

class { 'churchill-node' :
    require => Vcsrepo['/home/node-user/churchill'],
}

