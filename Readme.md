# Puppet bigbluebutton

Install bigbluebutton 0.8 and configure various parameters needed for setting quality etc.

## Requirements

### Ubuntu 10.04 Server
* [Camptocamp apt module]

## Usage

class {'bigbluebutton':
    salt => 'secureserversalt';
}

See the bigbluebutton class for more parameters to use for configuration of the server.

[camptocamp apt module]: https://github.com/camptocamp/puppet-apt
