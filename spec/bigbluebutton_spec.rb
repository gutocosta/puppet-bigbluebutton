require 'spec_helper'

describe 'bigbluebutton' do
  context 'on a Ubuntu OS' do
    let :facts do

      {
        kernel:                 'Linux',
        osfamily:               'Debian',
        operatingsystem:        'Ubuntu',
        operatingsystemrelease: '16.04',
      }
    end
    it { is.expected_to contain_class('bigbluebutton::pre_install') }
    it { is.expected_to contain_class('bigbluebutton::install') }
    it { is.expected_to contain_class('bigbluebutton::repos') }
    it { is.expected_to contain_class('bigbluebutton::params') }
    it { is.expected_to contain_class('bigbluebutton::config') }
    it { is.expected_to contain_class('bigbluebutton::service') }
  end
end
