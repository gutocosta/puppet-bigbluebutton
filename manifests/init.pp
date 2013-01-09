# == Class: bigbluebutton
#
# Install and configure bigbluebutton meeting server
#
# === Parameters:
#
# $salt::                 default salt for rest authentication
#
# $help_url::             The url to redirect users to after clicking the help button, this defaults to an internal
#                         bigbluebutton page with help information about the software.
#
# $enable_skin::          Enable theming for bigbluebutton, when set to false this uses the default bigbluebutton
#                         theme available. When setting this to true you need to specify a skin url for the $theme_skin
#                         parameter where the skin can be found.
#
# $theme_skin::           Url/Location where the skin file can be found
#
# $translation_on::       Enable automatic translations in the chat modules. When set to true chat messages will be
#                         automatically translated to the users selected language. Note: This feature does not work
#                         for the moment due to google disabling this service.
#
# $translation_enabled::  Enable translations, when set to true users can translated the chat messages when they want
#                         to. The messages are not translated automatically. Same note as above applies.
#
# $private_chat::         Allow private chats between users.
#
# $allow_kick_user::      Allow kicking of users by the moderators in the conference.
#
# $phone_auto_join::      Auto join phone conference after logging in.
#
# $phone_skip_check::     skip?
#
# $video_quality::        Set to a value between 100 - 0 where 100 is best quality with no compression
#
# $presenter_share_only:: When set to true only the presenter is allowed to share his webcam. This is great for
#                         one-to-many conferences.
#
# $resolutions::          Set a list of available resolutions that can be chosen in the webcam quality dropdown
#
# $cam_mode_fps::         see http://code.google.com/p/bigbluebutton/wiki/FAQ#How_do_I_change_the_video_quality_of_the_shared_webcams?
#
# $cam_quality_bandwith:: see http://code.google.com/p/bigbluebutton/wiki/FAQ#How_do_I_change_the_video_quality_of_the_shared_webcams?
#
# $cam_quality_picture::  see http://code.google.com/p/bigbluebutton/wiki/FAQ#How_do_I_change_the_video_quality_of_the_shared_webcams?
#
# $enable_h264::          Enable h264 encoding, still in beta and does not work with default bigbluebutton installs
#
# === Requires:
#
# - Ubuntu 10.04 LTS server
# - puppet apt module: https://github.com/camptocamp/puppet-apt
#
# === Sample Usage:
#
# -Install and configure default bigbluebutton :
#
# include bigluebutton
#
# - Install bigbluebutton with custom configuration
#
#  class bigbluebutton {
#   salt        => 'uielre5654cssd',
#   resolutions => '320x480, 480x640';
#  }
#
class bigbluebutton (
  $salt                 = $bigbluebutton::params::salt,
  $help_url             = $bigbluebutton::params::help_url,
  $enable_skin          = $bigbluebutton::params::enable_skin,
  $theme_skin           = $bigbluebutton::params::theme_skin,
  $translation_on       = $bigbluebutton::params::translation_on,
  $translation_enabled  = $bigbluebutton::params::translation_enabled,
  $private_chat         = $bigbluebutton::params::private_chat,
  $allow_kick_user      = $bigbluebutton::params::allow_kick_user,
  $phone_auto_join      = $bigbluebutton::params::phone_auto_join,
  $phone_skip_check     = $bigbluebutton::params::phone_skip_check,
  $video_quality        = $bigbluebutton::params::video_quality,
  $presenter_share_only = $bigbluebutton::params::presenter_share_only,
  $resolutions          = $bigbluebutton::params::resolutions,
  $cam_mode_fps         = $bigbluebutton::params::cam_mode_fps,
  $cam_quality_bandwith = $bigbluebutton::params::cam_quality_bandwith,
  $cam_quality_picture  = $bigbluebutton::params::cam_quality_picture,
  $enable_h264          = $bigbluebutton::params::enable_h264
) inherits bigbluebutton::params
{
  class{'bigbluebutton::repos':;} ~>
  class{'bigbluebutton::config_ruby':;} ~>
  class{'bigbluebutton::pre_install':;} ~>
  class{'bigbluebutton::install':;} ~>
  class{'bigbluebutton::config':;} ~>
  class{'bigbluebutton::service':;}
}
