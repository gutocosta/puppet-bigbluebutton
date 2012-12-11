class bigbluebutton::install {

  file {'/var/local/preseed':
    ensure => 'directory';
  }

  file {'/var/local/preseed/bigbluebutton.preseed':
    ensure  => file,
    source => 'puppet:///modules/bigbluebutton/bigbluebutton.preseed',
    require => File['/var/local/preseed'];
  }

  package { 'bigbluebutton':
    ensure       => installed,
    responsefile => '/var/local/preseed/bigbluebutton.preseed',
    require      => File['/var/local/preseed/bigbluebutton.preseed'];
  }
}
