class bigbluebutton::install {

  package { 'bigbluebutton':
    ensure       => installed,
    responsefile => 'puppet:///modules/bigbluebutton/bigbluebutton.preseed'
  }
}
