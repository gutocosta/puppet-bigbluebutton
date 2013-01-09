class bigbluebutton::service
{
  exec {
    'restartbbb':
      command     => '/usr/local/bin/bbb-conf --restart',
      refreshonly => true;
# Not yet used
#    'startbbb':
#      command     => '/usr/local/bin/bbb-conf --start',
#      refreshonly => true;
#    'stopbbb':
#      command     => '/usr/local/bin/bbb-conf --stop',
#      refreshonly => true;
  }
}
