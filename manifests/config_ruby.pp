class bigbluebutton::config_ruby {

  package {
    'ruby1.9.2':
      ensure => installed;
    'rubygems1.9.2':
      ensure => installed;
    'make':
      ensure => installed;
    'ruby1.9.2-dev':
      ensure => installed;
    'libopenssl-ruby1.9.2':
      ensure => installed;
  }

  file {'/etc/profile.d/ruby.sh':
    ensure  => present,
    source  => 'puppet:///modules/bigbluebutton/ruby.sh',
    owner   => 'root',
    group   => 'root',
    mode    => '0644';
  }

}
