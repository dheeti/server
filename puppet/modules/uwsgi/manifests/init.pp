class uwsgi {

    $params = {
        "uid" => "www-data",
        "gid" => "www-data",
        "socket" => "/tmp/dlab-api.sock",
        "logdate" => "",
        "optimize" => 2,
        "processes" => 2,
        "master" => "",
        "die-on-term" => "",
        "logto" => "/var/log/dlab-api.log",
        "chdir" => "/var/www/api",
        "module" => "wsgi",
    }

    package { "upstart":
        ensure => installed,
    }
    
    package { "uwsgi":
        ensure => installed,
        provider => pip,
        require => [Class["python::packages"], Package["upstart"]],
    }
    
    file { "/etc/init/dlab-api.conf":
        ensure => present,
        owner => "root",
        group => "root",
        mode => "0644",
        content => template("uwsgi/uwsgi.conf.erb"),
        require => Package["uwsgi"],
    }
    
    file { "/var/log/dlab-api.log":
        ensure => present,
        owner => "api-user",
        mode => "0755",
        require => User["api-user"],
    }
    
    service { "uwsgi":
        ensure => running,
        provider => upstart,
        enable => true,
        hasrestart => false,
        hasstatus => false,
        require => [File["/etc/init/dlab-api.conf"], File["/var/log/dlab-api.log"]],
    }
}
