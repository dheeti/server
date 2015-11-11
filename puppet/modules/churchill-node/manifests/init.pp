class churchill-node {

    file { "/etc/init/churchill-node.conf":
        mode   => 644,
        owner  => root,
        group  => root,
        source => "puppet:///modules/churchill-node/upstart.conf"
    }
}
