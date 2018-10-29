# == Class: base
#
# Performs initial configuration tasks for Vagrant boxes.
#
class vagrant::base {

  Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] }

  $timezone = 'Europe/London'
  $set_timezone = [$timezone]
  $set_timezone_file = '/etc/timezone'

  case $::osfamily {
      /Debian/: {

        $packages = ['htop','tree','unzip','vim']

        file { $set_timezone_file:
          content => $set_timezone,
          notify  => Exec['update timezone'];
        }
        exec { 'apt-get update':
          command => 'apt update';
        }
        package { $packages:
          ensure => present;
        }
        exec { 'update timezone':
          command => 'dpkg-reconfigure -f noninteractive tzdata';
        }

      } default: {

        $packages = ['htop','tree','unzip','vim-common']

        exec { 'yum update':
          command => 'yum update';
        }
        package { $packages:
          ensure => present;
        }
        exec { 'update timezone':
          command => "timedatectl set-timezone ${timezone}";
        }

      }
  }

}
