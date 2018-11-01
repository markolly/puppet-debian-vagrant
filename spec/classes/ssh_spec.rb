require 'spec_helper'
describe 'debian_vagrant::ssh' do
  let(:facts) do
    {
      kernel: 'Linux',
      operatingsystem: 'Ubuntu',
      operatingsystemmajrelease: '16.04',
      operatingsystemrelease: '16.04',
      osfamily: 'Debian'
    }
  end
  it { should contain_class('debian_vagrant::ssh') }
  it { should compile }
  it { should contain_file('/etc/ssh/sshd_config') }
  it do
    should contain_file_line('Configure UseDNS in SSH daemon')
      .with(
        path: '/etc/ssh/sshd_config',
        line: 'UseDNS no',
        match: '^UseDNS'
      )
  end
  it do
    should contain_file_line('Configure GSSAPIAuthentication in SSH daemon')
      .with(
        path: '/etc/ssh/sshd_config',
        line: 'GSSAPIAuthentication no',
        match: '^GSSAPIAuthentication'
      )
  end
  it do
    should contain_file('/home/vagrant/.ssh')
      .with(
        ensure: 'directory',
        owner: 'vagrant',
        group: 'vagrant',
        mode: '0700'
      )
  end
  it do
    should contain_file('/home/vagrant/.ssh/authorized_keys')
      .with(
        ensure: 'present',
        owner: 'vagrant',
        group: 'vagrant',
        mode: '0600'
      )
  end
end
