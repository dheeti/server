class users {
    
    group { 'www-data':
        ensure => present,
    }

    user { 'flask-user':
        ensure => present,
        groups => ['www-data'],
        membership => minimum,
        shell => "/bin/bash",
        require => Group['www-data']
    }
}
