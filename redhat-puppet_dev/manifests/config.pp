# == Class: puppet_dev::config
#
# Class to set up puppet_dev module configuration files, and system
# configuration.
#
# === Parameters
#
# Document parameters here.
#
# [*satellite_server*]
#   The URL of the Satellite Server, default 'stallite.example.com'
# [*puppetdb_server*]
#   The fqdn of the PuppetDB server, default 'puppetdb.example.com'
# [*puppetdb_port*]
#   The port number the PuppetDB server is listening on, default '8080'
# [*storeconfigs*]
#   Wheater to enable storeconfigs or not.
# [*ssldir*]
#   Where SSL certificates are kept.
#
# === Variables
#
# === Examples
#
# class { 'puppet_dev::config':
#   satellite_server => $satellite_server,
#   $storeconfigs    => true,
#   $ssldir          => '/var/lib/puppet/ssl',
#   $puppetdb_server => 'puppetdb.example.com',
#   $puppetdb_port   => '8080',
# }
#
# === Authors
#
# David Juran <djuran@redhat.com>
# Peter Gustafsson <pgustaft@redhat.com>
# Harald Jensås <hjensas@redhat.com>
#
# === Copyright
#
# Copyright 2014 The Authors
#
class puppet_dev::config(
  $satellite_server = 'sat6.example.com',
  $storeconfigs     = false,
  $ssldir           = '/var/lib/puppet/ssl',
  $puppetdb_server  = 'puppetdb.example.com',
  $puppetdb_port    = '8080',
) {

  file { '/etc/puppet_dev':
    ensure => 'directory',
    owner  => 'puppet',
    group  => 'puppet',
    mode   => '0750',
  }

  file { '/etc/puppet_dev/node.sh':
    ensure  => file,
    owner   => 'puppet',
    group   => 'puppet',
    mode    => '0750',
    require => File['/etc/puppet_dev'],
    content => template('puppet_dev/node.sh.erb'),
  }

  file { '/etc/puppet_dev/puppet_dev.conf':
    ensure  => file,
    owner   => 'puppet',
    group   => 'puppet',
    mode    => '0644',
    require => File['/etc/puppet_dev'],
    content => template('puppet_dev/puppet_dev.conf.erb'),
  }
  file { '/usr/local/bin/puppet_dev_run':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0750',
    content => template('puppet_dev/puppet_dev_run.erb'),
  }

  if $storeconfigs {
    file { '/etc/puppet/puppetdb.conf':
        ensure  => file,
        owner   => 'root',
        group   => 'root',
        mode    => '0750',
        content => template('puppet_dev/puppet_dev.puppetdb.conf'),
    }
  }

  #puppet should not sporadically run while developing
  service { 'puppet':
    ensure => 'stopped',
    enable => false,
  }
}
