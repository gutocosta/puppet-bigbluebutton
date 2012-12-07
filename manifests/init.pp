class bigbluebutton {

  include bigbluebutton::config_ruby
  include bigbluebutton::install

  Class['bigbluebutton::config_ruby'] ->
  Class['bigbluebutton::install']
}
