class bigbluebutton::pre_install {
  
  package {"builder":
    ensure   => installed,
    provider => gem;
  }

  package { "god":
    ensure   => installed,
    provider => 'gem';
  }

}
