# == Class: bigbluebutton::config
#
# This class manages the configuration of bigbluebutton
#

class bigbluebutton::config {

  require bigbluebutton::params

  $help_url = $bigbluebutton::params::help_url
  $enable_skin = $bigbluebutton::params::enable_skin
  $theme_skin = $bigbluebutton::params::theme_skin
  $translation_on = $bigbluebutton::params::translation_on
  $translation_enabled = $bigbluebutton::params::translation_enabled
  $private_chat = $bigbluebutton::params::private_chat
  $allow_kick_user = $bigbluebutton::params::allow_kick_user
  $phone_auto_join = $bigbluebutton::params::phone_auto_join
  $phone_skip_check = $bigbluebutton::params::phone_skip_check
  $video_quality = $bigbluebutton::params::video_quality
  $presenter_share_only = $bigbluebutton::params::presenter_share_only
  $resolutions = $bigbluebutton::params::resolutions
  $cam_mode_fps = $bigbluebutton::params::cam_mode_fps
  $cam_quality_bandwith = $bigbluebutton::params::cam_quality_bandwith
  $cam_quality_picture = $bigbluebutton::params::cam_quality_picture
  $enable_h264 = $bigbluebutton::params::enable_h264

  exec {
    'sethostname':
      command => "/usr/local/bin/bbb-conf --setip $i{::fqdn}",
      unless  => '/usr/local/bin/bbb-conf --check';
    'setsalt':
      command => "/usr/local/bin/bbb-conf --salt ${bigbluebutton::params::salt}",
      notify  => Exec['restartbbb'],
      unless  => "/usr/local/bin/bbb-conf --salt | /bin/grep -q ${bigbluebutton::params::salt}";
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
    ensure    => file,
    content => template('bigbluebutton/bigbluebutton-nginx.erb'),
    notify  => Exec['restartbbb'],
    require => Package['bigbluebutton'];
  }

  file { '/var/www/bigbluebutton/client/conf/config.xml':
    ensure  => file,
    content => template('bigbluebutton/config.xml.erb'),
    notify  => Exec['restartbbb'],
    require => Package['bigbluebutton'];
  }
}
