class bigbluebutton {

  include bigbluebutton::repos
  include bigbluebutton::config_ruby
  include bigbluebutton::pre_install
  include bigbluebutton::install

  Class['bigbluebutton::repos'] ->
  Class['bigbluebutton::config_ruby'] ->
  Class['bigbluebutton::pre_install'] ->
  Class['bigbluebutton::install']
}
