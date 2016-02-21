class packages {
    $apt = ['git', 'nodejs', 'unzip', ]

    package { $apt:
        ensure => installed,
    }
}
