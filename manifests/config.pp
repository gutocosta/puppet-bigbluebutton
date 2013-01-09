# == Class: bigbluebutton::config
#
# This class manages the configuration of bigbluebutton
#

class bigbluebutton::config {

  exec {
    'sethostname':
      command => "/usr/local/bin/bbb-conf --setip ${::fqdn}",
      unless  => '/usr/local/bin/bbb-conf --check';
    'setsalt':
      command => "/usr/local/bin/bbb-conf --salt ${bigbluebutton::salt}",
      notify  => Exec['restartbbb'],
      unless  => "/usr/local/bin/bbb-conf --salt | /bin/grep -q ${bigbluebutton::salt}";
    'cleanbbb':
      command     => '/usr/local/bin/bbb-conf --clean',
      refreshonly => true;
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
}
