require 'spec_helper'
describe 'debian_vagrant::vboxguest' do
  let(:facts) do
    {
      kernel: 'Linux',
      operatingsystem: 'Debian',
      operatingsystemmajrelease: '9',
      operatingsystemrelease: '9',
      osfamily: 'Debian'
    }
  end
  it { should contain_class('debian_vagrant::vboxguest') }
  it { should compile }
  it do
    should contain_exec('Ensure correct kernel headers are installed')
      .with(
        command: 'apt -y install linux-headers-$(uname -r)'
      )
  end
  it do
    should contain_exec('Create /media/VBoxGuestAdditions')
      .with(
        command: 'mkdir -p /media/VBoxGuestAdditions',
        creates: '/media/VBoxGuestAdditions'
      )
  end
  it do
    should contain_exec('Mount VBoxGuestAdditions')
      .with(
        command: "mount -o loop,ro \
                /home/vagrant/VBoxGuestAdditions_5.1.20.iso \
                /media/VBoxGuestAdditions"
      )
  end
  it do
    should contain_exec('Install VBoxGuestAdditions')
      .with(
        command: 'sh /media/VBoxGuestAdditions/VBoxLinuxAdditions.run',
        returns: 2
      )
  end
  it do
    should contain_file('/home/vagrant/VBoxGuestAdditions_5.1.20.iso')
      .with(
        ensure: 'absent'
      )
  end
  it do
    should contain_exec('Unmount VBoxGuestAdditions')
      .with(
        command: 'umount /media/VBoxGuestAdditions'
      )
  end
  it do
    should contain_exec('Remove /media/VBoxGuestAddition')
      .with(
        command: 'rm -r /media/VBoxGuestAdditions'
      )
  end
end
