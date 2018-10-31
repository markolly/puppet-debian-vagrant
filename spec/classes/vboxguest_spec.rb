require 'spec_helper'
describe 'vagrant::vboxguest' do
  let(:facts) do
    {
      kernel: 'Linux',
      operatingsystem: 'Ubuntu',
      operatingsystemmajrelease: '16.04',
      operatingsystemrelease: '16.04',
      osfamily: 'Debian'
    }
  end
  it { should contain_class('vagrant::vboxguest') }
  it { should compile }
end
