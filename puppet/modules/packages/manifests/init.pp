class packages {
    $apt = ['git', 'nodejs', 'npm', 'python-virtualenv']

    package { $apt:
        ensure => installed,
    }
}
