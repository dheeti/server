# install git, nodejs, npm
class { 'packages': }

# install python dependencies
class {'python': 
    require     => Class['packages'],
}

# create node-user
class { 'users':
    require     => Class['packages'],
}

include nginx
include uwsgi

# clone churchill into vagrant shared folder
vcsrepo { '/vagrant/churchill':
    require     => Class['users'],
    ensure      => present,
    provider    => git,
    source      => 'https://github.com/psu-capstone/churchill.git',
    revision    => 'deploy',
    owner       => 'admin',
    group       => 'admin',
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
class { 'churchill-node':
    require     => File['/home/node-user/churchill'],
}

vcsrepo { '/vagrant/api':
    require     => Class['users'],
    ensure      => present,
    provider    => git,
    source      => 'https://github.com/psu-capstone/dlab-api.git',
    revision    => 'develop',
    owner       => 'admin',
    group       => 'admin',
}

file { '/var/www': 
    require     => Vcsrepo['/vagrant/api'],
    ensure      => 'directory',
    owner       => www-data,
    group       => www-data,
}

file { '/var/www/api': 
    require     => File['/var/www'],
    ensure      => link,
    target      => '/vagrant/api',
    owner       => www-data,
    group       => www-data,
}

