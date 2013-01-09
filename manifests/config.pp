# == Class: bigbluebutton::config
#
# This class manages the configuration of bigbluebutton
#

class bigbluebutton::config {

  exec {
    'restartbbb':
      command     => '/usr/local/bin/bbb-conf --restart',
      refreshonly => true;
    'startbbb':
      command     => '/usr/local/bin/bbb-conf --start',
      refreshonly => true;
    'stopbbb':
      command     => '/usr/local/bin/bbb-conf --stop',
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

  file { '/var/lib/tomcat6/webapps/bigbluebutton/WEB-INF/classes/bigbluebutton.properties':
    ensure  => present,
    content => template('bigbluebutton/bigbluebutton.properties.erb'),
    notify  => Exec['restartbbb'],
    require => Package['bigbluebutton'];
  }

  file { '/usr/local/bigbluebutton/core/scripts/slides.yml':
    ensure  => present,
    content => template('bigbluebutton/slides.yml.erb'),
    notify  => Exec['restartbbb'],
    require => Package['bigbluebutton'];
  }
}
