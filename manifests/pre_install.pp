class bigbluebutton::pre_install {

  package { 'builder':
    ensure   => installed,
    provider => gem;
  }

  package { 'god':
    ensure   => installed,
    provider => 'gem';
  }

  package { 'bundler':
    ensure    => '1.2.1',
    provider  => 'gem';
  }

  file { '/etc/sudoers.d/secure_path':
    ensure  => present,
    mode    => '0440',
    owner   => 'root',
    group   => 'root',
    source  => 'puppet:///modules/bigbluebutton/secure_path';
  }

  file {'/etc/environment':
    ensure => present,
    mode   => '0644',
    owner  => 'root',
    group  => 'root',
    source => 'puppet:///modules/bigbluebutton/path';
  }
}
