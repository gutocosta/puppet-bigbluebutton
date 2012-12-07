class bigbluebutton::install {
  # big blue button
  apt::key { '328BD16D':
    source => 'http://ubuntu.bigbluebutton.org/bigbluebutton.asc'
  }

  apt::sources_list {'bigbluebutton':
    ensure  => present,
    content => 'deb http://ubuntu.bigbluebutton.org/lucid_dev_08/ bigbluebutton-$::lsbdistcodename main',
  }

  apt::sources_list {'multiverse':
    ensure => present,
    content => 'deb http://us.archive.ubuntu.com/ubuntu lucid multiverse'
  }

  package { 'bigbluebutton':
    ensure => installed;
  }
}
