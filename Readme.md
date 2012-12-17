# Puppet bigbluebutton

Install bigbluebutton 0.8 and configure various parameters needed for setting quality etc.

## Requirements

### Ubuntu 10.04 Server
* [Camptocamp apt module]

## Usage

class {'bigbluebutton::params':
    salt => 'secureserversalt';
}

include bigbluebutton

See the bigbluebutton::params class for more parameters to use for configuration of the server.


