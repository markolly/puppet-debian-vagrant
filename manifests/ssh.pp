# == Class: debian_vagrant::ssh
#
# Configure SSH and install Vagrant SSH key
#
class debian_vagrant::ssh {

  include wget

  # SSH daemon configuration.
  file { '/etc/ssh/sshd_config':
    ensure => present,
  }
  -> file_line { 'Configure UseDNS in SSH daemon':
    path  => '/etc/ssh/sshd_config',
    line  => 'UseDNS no',
    match => '^UseDNS',
  }
  ~> file_line { 'Configure GSSAPIAuthentication in SSH daemon':
    path  => '/etc/ssh/sshd_config',
    line  => 'GSSAPIAuthentication no',
    match => '^GSSAPIAuthentication',
  }

  # Vagrant SSH configuration.
  file { '/home/vagrant/.ssh':
    ensure => 'directory',
    owner  => 'vagrant',
    group  => 'vagrant',
    mode   => '0700',
  }
  -> wget::fetch { 'Get Vagrants public key':
    source             => 'https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub',
    destination        => '/home/vagrant/.ssh/authorized_keys',
    timeout            => 0,
    verbose            => true,
    nocheckcertificate => true,
  }
  ~> file { '/home/vagrant/.ssh/authorized_keys':
    ensure => 'present',
    owner  => 'vagrant',
    group  => 'vagrant',
    mode   => '0600',
  }

}
