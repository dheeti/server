class packages {
    $apt = ['git', 'nodejs', 'npm', ]

    package { $apt:
        ensure => installed,
    }
}
