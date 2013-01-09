# == Class: bigbluebutton::params
#
# Configuration paramaters for bigbluebutton
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

class bigbluebutton::params (
  $salt                 = '1b8ede0fg3d3c73re97b8c69qed478e4',
  $help_url             = "http://${::fqdn}/help",
  $enable_skin          = false,
  $theme_skin           = 'branding/css/theme.css.swf',
  $translation_on       = false,
  $translation_enabled  = false,
  $private_chat         = true,
  $allow_kick_user      = true,
  $phone_auto_join      = true,
  $phone_skip_check     = false,
  $video_quality        = '100',
  $presenter_share_only = false,
  $resolutions          = '320x240,640x480,1280x720',
  $cam_mode_fps         = '10',
  $cam_quality_bandwith = '0',
  $cam_quality_picture  = '90',
  $enable_h264          = false
) {
}
