class users {
    
    group { 'www-data':
        ensure => present,
    }

    user { 'flask-user':
        require => Group['www-data'],
        ensure => present,
        groups => ['www-data'],
        managehome => true,
        shell => "/bin/bash",
    }
}
