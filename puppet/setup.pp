class { 'java':
  distribution => 'jre',
}

class { 'neo4j' :
    require => Class['java'],
    jvm_init_memory => '128',
    jvm_max_memory  => '128',
}

include users
include python

