require 'spec_helper'
describe 'vagrant::ssh' do
  let(:facts) do
    {
      kernel: 'Linux',
      operatingsystem: 'Debian',
      operatingsystemmajrelease: '9',
      operatingsystemrelease: '9',
      osfamily: 'Debian'
    }
  end
  it { should contain_class('vagrant::ssh') }
  it { should compile }
end
