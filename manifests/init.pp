class bigbluebutton ( $salt = '' ) {

  class install
  {
    # big blue button
    apt::key { "328BD16D":
      source => "http://ubuntu.bigbluebutton.org/bigbluebutton.asc"
    }

    apt::sources_list {"bigbluebutton":
          ensure  => present,
          content => "deb http://ubuntu.bigbluebutton.org/lucid_dev_08/ bigbluebutton-$::lsbdistcodename main",
    }

    apt::sources_list {"multiverse":
        ensure => present,
        content => "deb http://us.archive.ubuntu.com/ubuntu lucid multiverse"
    }

    apt::ppa {"pratikmsinha":
      ensure => present,
      key    => '1024R/A84F68D2'
      ppa    => 'ruby192+bindings';
    }

    package {"ruby1.9.2":
        ensure => installed;
    }

    package {
      "bbb-freeswitch-config":
        ensure => installed;
      "bigbluebutton":
        ensure => installed;
    }
  }

  class config
  {
    Exec {
      require => Package['bigbluebutton']
    }

    exec {
      "sethostname":
        command => "/usr/local/bin/bbb-conf --setip $fqdn",
        unless  => "/usr/local/bin/bbb-conf --check";
      "setsalt":
        command => "/usr/local/bin/bbb-conf --salt $salt",
        notify  => Exec['restartbbb'],
        unless  => "/usr/local/bin/bbb-conf --salt | /bin/grep -q $salt";
      "cleanbbb":
        command     => "/usr/local/bin/bbb-conf --clean",
        refreshonly => true;
      "restartbbb":
        command     => "/usr/local/bin/bbb-conf --restart",
        refreshonly => true;
      "startbbb":
        command     => "/usr/local/bin/bbb-conf --start",
        refreshonly => true;
      "stopbbb":
        command     => "/usr/local/bin/bbb-conf --stop",
        refreshonly => true;
    }

    augeas{
      "freeswitch_destination_number" :
        lens => "Xml.lns",
        incl => "/opt/freeswitch/conf/dialplan/public.xml",
        context => "/files/opt/freeswitch/conf/dialplan/public.xml",
        changes => [
          "set include/context/*/condition[../#attribute/name = 'bbb_conferences']/#attribute/expression[ ../field = 'destination_number']  ^(\d{5})$"
        ],
        onlyif  => "get include/context/*/condition[../#attribute/name = 'bbb_conferences']/#attribute/expression[ ../field = 'destination_number'] != ^(\d{5})$",
        require => Package['bbb-freeswitch-config'],
        notify  => Exec['restartbbb'];
      "client_config":
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
      '/var/lib/tomcat6/webapps/bigbluebutton/demo/bbb_api_conf.jsp':
        content => template("bigbluebutton/bbb_api_conf.jsp.erb"),
        notify  => Exec['restartbbb'],
        require => Package['bigbluebutton'],
    }
  }

  include install
  include config
  Class['install'] -> Class['config']
}
