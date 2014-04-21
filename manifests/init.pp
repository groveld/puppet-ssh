# Module: ssh
#
class ssh (
    $port = '22',
    $keyregenerationinterval = '3600',
    $syslogfacility = 'AUTH',
    $loglevel = 'info',
    $logingracetime = '60',
    $permitrootlogin = 'no',
    $strictmodes = 'yes',
    $rsaauthentication = 'yes',
    $pubkeyauthentication = 'yes',
    $passwordauthentication = 'yes',
    $x11forwarding = 'no',
    $printmotd = 'no',
    $maxstartups = '10',
    $maxauthtries = '5' ) {

    package { 'openssh-server':
        ensure      => latest,
    }

    service { 'ssh':
        ensure      => running,
        enable      => true,
        subscribe   => File['sshdconfig'],
        require     => Package['openssh-server'],
    }

    file { 'sshdconfig':
        name        => '/etc/ssh/sshd_config',
        owner       => root,
        group       => root,
        mode        => '0644',
        content     => template('sshd/sshd_config.erb'),
        require     => Package['openssh-server'],
        notify      => Service['ssh'],
    }
}
