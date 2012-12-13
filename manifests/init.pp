# == Class: bigbluebutton
#
# Install and configure bigbluebutton meeting server
#
# === Parameters:
#
# Parameters are set in bigbluebutton::params, documentation
# for parameters is found there.
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
#  class bigbluebutton::params {
#   salt        => 'uielre5654cssd',
#   resolutions => '320x480, 480x640';
#  }
#
#  include bigbluebutton
#

class bigbluebutton {

  require bigbluebutton::params

  include bigbluebutton::repos
  include bigbluebutton::config_ruby
  include bigbluebutton::pre_install
  include bigbluebutton::install
  include bigbluebutton::config

  Class['bigbluebutton::repos'] ->
  Class['bigbluebutton::config_ruby'] ->
  Class['bigbluebutton::pre_install'] ->
  Class['bigbluebutton::install'] ->
  Class['bigbluebutton::config']
}
