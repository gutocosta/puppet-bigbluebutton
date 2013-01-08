class bigbluebutton::config_ruby {

  package {
    'ruby1.9.2':
      ensure => installed;
    'rubygems1.9.2':
      ensure => installed;
    'ruby1.9.2-dev':
      ensure => installed;
    'libopenssl-ruby1.9.2':
      ensure => installed;
  }
}
