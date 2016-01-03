define ssh-user ($username, $pub_key) {
    
    user { "${username}":
        ensure      => present,
        managehome  => true,
        shell       => "/bin/bash",
    }

    file { "/home/${username}/.ssh": 
        require => User["${username}"],
        ensure => 'directory',
    }

    file { "/home/${username}/.ssh/authorized_keys":
        source => "${pub_key}",
        mode => 400,
        owner => "${username}",
        group => "${username}",
    }

}
