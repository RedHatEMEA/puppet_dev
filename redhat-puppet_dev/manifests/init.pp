# == Class: puppet_dev
#
# Full description of class puppet_dev here.
#
# === Parameters
#
# Document parameters here.
#
# [*satellite_server*]
#   The fqdn of the Satellite Server, default 'sat6.example.com'
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
# Here you should define a list of variables that this module would require.
#
#
# === Examples
#
#  class { puppet_dev:
#    satellite_server => 'sat6.example.com',
#    storeconfigs     => true,
#    ssldir           => '/var/lib/puppet/ssl'
#    puppetdb_server  => 'puppetdb.example.com',
#    puppetdb_port    => '8080',
#  }
#
# === Authors
#
# David Juran <djuran@redhat.com>
# Peter Gustafsson <pgustaft@redhat.com>
# Harald Jensas <hjensas@redhat.com>
#
# === Copyright
#
# Copyright 2014 The Authors
#
class puppet_dev(
  $satellite_server = 'sat6.example.com',
  $storeconfigs      = false,
  $puppetdb_server  = 'puppetdb.example.com',
  $puppetdb_port    = '8080',
  $ssldir           = '/var/lib/puppet/ssl',
  $repo_path        = '/var/tmp/puppet',
  $git_repos        = ['git@github.com:EXAMPLE/example.git',
                      'git@github.com:EXAMPLE/example.git',]
) {

  # For Storeconfigs we need puppetdb
  if $storeconfigs {
    package {'puppetdb-terminus':
      ensure => installed,
    }
  }

  #create_repos { $git_repos:; }

  class { 'puppet_dev::config':
    satellite_server => $satellite_server,
    storeconfigs     => $storeconfigs,
    ssldir           => $ssldir,
    puppetdb_server  => $puppetdb_server,
    puppetdb_port    => $puppetdb_port,
  }
}
