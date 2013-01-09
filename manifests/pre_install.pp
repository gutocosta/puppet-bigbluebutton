class bigbluebutton::pre_install {

  package { 'builder':
    ensure   => installed,
    provider => 'gem';
  }

  package { 'god':
    ensure   => installed,
    provider => 'gem';
  }

  package { 'bundler':
    ensure    => '1.2.1',
    provider  => 'gem';
  }

  file {
    '/usr/bin/bundle':
      ensure => link,
      target => '/var/lib/gems/1.9.2/bin/bundle';
    '/usr/bin/god':
      ensure => link,
      target => '/var/lib/gems/1.9.2/bin/god';
  }

  file { '/etc/sudoers.d/secure_path':
    ensure  => present,
    mode    => '0440',
    owner   => 'root',
    group   => 'root',
    source  => 'puppet:///modules/bigbluebutton/secure_path';
  }

}
