require 'spec_helper'
describe 'vagrant::base' do
  let(:facts) do
    {
      kernel: 'Linux',
      operatingsystem: 'Debian',
      operatingsystemmajrelease: '9',
      operatingsystemrelease: '9',
      osfamily: 'Debian'
    }
  end
  it { should contain_class('vagrant::base') }
  it { should compile }

  it do
    should contain_exec('apt update').with(
      command: 'apt update'
    )
  end
  it do
    should contain_exec('update timezone').with(
      command: 'dpkg-reconfigure -f noninteractive tzdata'
    )
  end
  it do
    should contain_file('/etc/timezone').with(
      content: 'Europe/London',
      notify: 'Exec[update timezone]'
    )
  end
end
