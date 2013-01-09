class bigbluebutton::install {

  $preseed_file = '/var/cache/debconf/bigbluebutton.preseed'

  file {
    $preseed_file:
    ensure => present,
    source => 'puppet:///modules/bigbluebutton/bigbluebutton.preseed',
  }

  package { 'bigbluebutton':
    ensure       => installed,
    responsefile => $preseed_file,
    require      => File[$preseed_file];
  }
}
