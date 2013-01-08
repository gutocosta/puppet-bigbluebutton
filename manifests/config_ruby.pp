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

  exec {
    'update-alternatives ruby1.9.2':
      command =>  'update-alternatives --set ruby /usr/bin/ruby1.9.2',
#                    --slave /usr/bin/ri ri /usr/bin/ri1.9.2
#                    --slave /usr/bin/irb irb /usr/bin/irb1.9.2
#                    --slave /usr/bin/erb erb /usr/bin/erb1.9.2
#                    --slave /usr/bin/rdoc rdoc /usr/bin/rdoc1.9.2',
      unless  => 'test /etc/alternatives/ruby -ef /usr/bin/ruby1.9.2',
      require => Package['ruby1.9.2'];
    'update-alternatives gem1.9.2':
      command => 'update-alternatives --set gem /usr/bin/gem1.9.2',
      unless  => 'test /etc/alternatives/gem -ef /usr/bin/gem1.9.2',
      require => Package['rubygems1.9.2'];
  }
}
