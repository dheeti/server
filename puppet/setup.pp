class { 'java':
  distribution => 'jre',
}

class { 'neo4j' :
    require         => Class['java'],
    version         => '2.3.1',
    edition         => 'community',
    install_prefix  => '/opt/neo4j',
    jvm_init_memory => '128',
    jvm_max_memory  => '128',
}

# install git, nodejs, npm
class { 'packages' : }

# create node-user
class { 'users' :
    require     => Class['packages'],
}

# clone churchill into vagrant shared folder
vcsrepo { '/vagrant/churchill':
    require     => Class['users'],
    ensure      => present,
    provider    => git,
    source      => 'https://github.com/psu-capstone/churchill.git',
    revision    => 'master',
}

# create symlink so node-user service can access churchill
file { '/home/node-user/churchill': 
    require     => Vcsrepo['/vagrant/churchill'],
    ensure      => link,
    target      => '/vagrant/churchill',
    owner       => node-user,
    group       => node-user,
}

# deploy upstart script to start churchill as service
class { 'churchill-node' :
    require     => File['/home/node-user/churchill'],
}
