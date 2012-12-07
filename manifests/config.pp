class bigbluebutton::config {

  Exec {
    require => Package['bigbluebutton']
  }

  exec {
    'sethostname':
      command => "/usr/local/bin/bbb-conf --setip $fqdn",
      unless  => '/usr/local/bin/bbb-conf --check';
    'setsalt':
      command => "/usr/local/bin/bbb-conf --salt $salt",
      notify  => Exec['restartbbb'],
      unless  => "/usr/local/bin/bbb-conf --salt | /bin/grep -q $salt";
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

  augeas{
    'freeswitch_destination_number' :
      lens => "Xml.lns",
      incl => "/opt/freeswitch/conf/dialplan/public.xml",
      context => "/files/opt/freeswitch/conf/dialplan/public.xml",
      changes => [
        "set include/context/*/condition[../#attribute/name = 'bbb_conferences']/#attribute/expression[ ../field = 'destination_number']  ^(\d{5})$"
      ],
      onlyif  => "get include/context/*/condition[../#attribute/name = 'bbb_conferences']/#attribute/expression[ ../field = 'destination_number'] != ^(\d{5})$",
      require => Package['bbb-freeswitch-config'],
      notify  => Exec['restartbbb'];
    'client_config':
      lens => "Xml.lns",
      incl => "/var/www/bigbluebutton/client/conf/config.xml",
      context => "/files/var/www/bigbluebutton/client/conf/config.xml",
      changes => [
        "set config/skinning/#attribute/enabled true",
        "set config/skinning/#attribute/url  branding/css/UGent.swf",
        "set config/modules/module[*]/#attribute/translationOn[ ../name = 'ChatModule'] false",
        "set config/modules/module[*]/#attribute/allowKickUser[ ../name = 'ViewersModule'] true",
        "set config/modules/module[*]/#attribute/autoJoin[ ../name = 'PhoneModule'] true",
        "set config/modules/module[*]/#attribute/videoQuality[ ../name = 'VideoconfModule'] 85",
        "set config/modules/module[last()+1]/#attribute/name BreakoutModule",
        "set config/modules/module[last()]/#attribute/url BreakoutModule.swf?v=3798",
        "set config/modules/module[last()]/#attribute/uri rtmp://$fqdn/bigbluebutton",
        "set config/modules/module[last()]/#attribute/host http://$fqdn",
        "set config/modules/module[last()]/#attribute/dependsOn ViewersModule",
        "set config/modules/module[last()]/#attribute/salt $salt"
      ],
      onlyif  => "match config/modules/*/#attribute/name[ . = 'BreakoutModule'] size == 0",
      notify  => [Exec['setsalt'],Exec['restartbbb']],
      require => Package['bigbluebutton'],
  }

  file {
    '/etc/nginx/sites-available/bigbluebutton':
      content => template("bigbluebutton/bigbluebutton-nginx.erb"),
      notify  => Exec['restartbbb'],
      require => Package['bigbluebutton'];
  }
}
