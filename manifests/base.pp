# == Class: debian_vagrant::base
#
# Performs initial configuration tasks for Debian Vagrant boxes.
#
class debian_vagrant::base {

  Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] }

  file { '/etc/timezone':
    content => 'Europe/London',
    notify  => Exec['update timezone'];
  }
  exec { 'apt update':
    command => 'apt update';
  }
  package { ['htop','tree','unzip','vim']:
    ensure => present;
  }
  exec { 'update timezone':
    command => 'dpkg-reconfigure -f noninteractive tzdata';
  }

}
