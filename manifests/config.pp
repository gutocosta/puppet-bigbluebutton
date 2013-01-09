# == Class: bigbluebutton::config
#
# This class manages the configuration of bigbluebutton
#

class bigbluebutton::config {

  file { '/etc/nginx/sites-available/bigbluebutton':
    ensure  => file,
    content => template('bigbluebutton/bigbluebutton-nginx.erb');
  }

  file { '/var/www/bigbluebutton/client/conf/config.xml':
    ensure  => present,
    content => template('bigbluebutton/config.xml.erb');
  }

  file { '/var/lib/tomcat6/webapps/bigbluebutton/WEB-INF/classes/bigbluebutton.properties':
    ensure  => present,
    content => template('bigbluebutton/bigbluebutton.properties.erb');
  }

  file { '/usr/local/bigbluebutton/core/scripts/slides.yml':
    ensure  => present,
    content => template('bigbluebutton/slides.yml.erb');
  }
}
