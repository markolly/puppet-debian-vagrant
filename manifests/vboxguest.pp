# == Class: vagrant::vboxguest
#
# Download and install VBox Guest Additions
#
class vagrant::vboxguest {

  Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] }

  $virtualbox_version = generate('/bin/cat', '/home/vagrant/.vbox_version')

  case $::osfamily {
      /Debian/: {

        exec { 'Ensure correct kernel headers are installed':
          command => "apt -y install linux-headers-$(uname -r)",
        }

      } default: {

        exec { 'Ensure correct kernel headers are installed':
          command => "yum -y install linux-headers-$(uname -r)",
        }

      }
  }

  exec { 'Create /media/VBoxGuestAdditions':
    command => 'mkdir -p /media/VBoxGuestAdditions',
    creates => '/media/VBoxGuestAdditions',
  } ->
  wget::fetch { 'Get VBoxGuestAdditions':
    source             => "http://download.virtualbox.org/virtualbox/${virtualbox_version}/VBoxGuestAdditions_${virtualbox_version}.iso",
    destination        => "/home/vagrant/VBoxGuestAdditions_${virtualbox_version}.iso",
    timeout            => 0,
    verbose            => true,
    nocheckcertificate => true,
  } ->
  exec { 'Mount VBoxGuestAdditions':
    command => "mount \
      -o loop,ro /home/vagrant/VBoxGuestAdditions_${virtualbox_version}.iso /media/VBoxGuestAdditions",
  } ->
  exec { 'Install VBoxGuestAdditions':
    command => "sh /media/VBoxGuestAdditions/VBoxLinuxAdditions.run",
    returns => 2,
  } ->
  file { "/home/vagrant/VBoxGuestAdditions_${virtualbox_version}.iso":
    ensure => 'absent',
  } ->
  exec { 'Unmount VBoxGuestAdditions':
    command => "umount /media/VBoxGuestAdditions",
  } ->
  exec { 'Remove /media/VBoxGuestAddition':
    command => 'rm -r /media/VBoxGuestAdditions',
  }

}
