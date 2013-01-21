# == Class: homedir
#
# Configure my personal home directory.  Shared, but not expected to be
# generally useful.
#
# Inspired by this blog post:
# http://vstone.eu/bootstrap-your-home-folder-puppet/
#
# === Parameters
#
# [*path*]
#   Path to home directory
#
# === Examples
#
# include homedir
#
# === Authors
#
# Andrew Leonard
#
# === Copyright
#
# Copyright 2013 Andrew Leonard
#
class homedir(
  $path = '/home/aleonard',
  ) {

  file { "${path}/.bashrc":
    mode   => '0400',
    source => 'puppet:///modules/homedir/bashrc',
  }

  file { "${path}/.profile":
    mode   => '0400',
    source => 'puppet:///modules/homedir/profile',
  }

  file { "${path}/.bashrc.d":
    ensure => directory,
    mode   => '0700',
  }
}
