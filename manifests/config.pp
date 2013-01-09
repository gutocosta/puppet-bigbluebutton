# == Class: bigbluebutton::config
#
# This class manages the configuration of bigbluebutton
#

class bigbluebutton::config {

  exec {
    'restartbbb':
      command     => '/usr/local/bin/bbb-conf --restart',
      returns     => 1,
      refreshonly => true;
    'startbbb':
      command     => '/usr/local/bin/bbb-conf --start',
      returns     => 1,
      refreshonly => true;
    'stopbbb':
      command     => '/usr/local/bin/bbb-conf --stop',
      returns     => 1,
      refreshonly => true;
  }

  file { '/etc/nginx/sites-available/bigbluebutton':
    ensure  => file,
    content => template('bigbluebutton/bigbluebutton-nginx.erb'),
    notify  => Exec['restartbbb'],
    require => Package['bigbluebutton'];
  }

  file { '/var/www/bigbluebutton/client/conf/config.xml':
    ensure  => present,
    content => template('bigbluebutton/config.xml.erb'),
    notify  => Exec['restartbbb'],
    require => Package['bigbluebutton'];
  }
}
