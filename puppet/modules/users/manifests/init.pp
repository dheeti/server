class users {
    
    group { 'www-data':
        ensure => present,
    }

    user { 'node-user':
        require => Group['www-data'],
        ensure => present,
        groups => ['www-data'],
        managehome => true,
        shell => "/bin/bash",
    }

    user { 'jeff':
        ensure => present,
        managehome => true,
        shell => "/bin/bash",
    }

    ssh_authorized_key { 'jeff_ssh':
        user => "jeff",
        type => "rsa",
        key => "puppet:///modules/users/jeff.pub",
    } 
}
