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
# Michael Williams
#
# === Copyright
#
# Copyright 2013 Andrew Leonard
#
class homedir(
  $user = 'michael',
  $path = '/home/michael',
  ) {

  user { "${user}":
    ensure => present,
    comment => "${user}",
    gid => "${user}",
    groups => ["sudo", "rvm"],
    home => "/home/${user}",
    shell => '/bin/zsh',
  }

  #exec { "${user} homedir":
  #  command => "/bin/cp -R /etc/skel /home/${user}; /bin/chown -R ${user}:$group /home/${user}",
  #  creates => "/home/{$user}",
  #  require => User[$user],
  #}

  file { "${path}/.zshrc":
    mode   => '0400',
    source => 'puppet:///modules/homedir/zshrc',
    owner => "${user}",
    group => "${user}",
  }

  file { "${path}/.zprofile":
    mode   => '0400',
    source => 'puppet:///modules/homedir/zprofile',
    owner => "${user}",
    group => "${user}",
  }
  
  file { "${path}/.zlogin":
    mode   => '0400',
    source => 'puppet:///modules/homedir/zlogin',
    owner => "${user}",
    group => "${user}",
  }

  file { "${path}/.zshenv":
    mode   => '0400',
    source => 'puppet:///modules/homedir/zshenv',
    owner => "${user}",
    group => "${user}",
  }

  file { "${path}/.xsession":
    mode   => '0400',
    source => 'puppet:///modules/homedir/xsession',
    owner => "${user}",
    group => "${user}",
  }

  file { "${path}/.xinitrc":
    mode   => '0400',
    source => 'puppet:///modules/homedir/xinitrc',
    owner => "${user}",
    group => "${user}",
  }

  file { "${path}/.vimrc":
    mode   => '0400',
    source => 'puppet:///modules/homedir/vimrc',
    owner => "${user}",
    group => "${user}",
  }

  file { "${path}/.tmux.conf":
    mode   => '0400',
    source => 'puppet:///modules/homedir/tmux.conf',
    owner => "${user}",
    group => "${user}",
  }

  file { "${path}/.gitconfig":
    mode   => '0400',
    source => 'puppet:///modules/homedir/gitconfig',
    owner => "${user}",
    group => "${user}",
  }

  file { "${path}/.Xresources":
    mode   => '0400',
    source => 'puppet:///modules/homedir/Xresources',
    owner => "${user}",
    group => "${user}",
  }

  vcsrepo { "${path}/.oh-my-zsh":
      ensure => 'present',
      provider => 'git',
      source => 'https://github.com/robbyrussell/oh-my-zsh',
      user => "${user}",
      group => "${user}",
  }

  file { "${path}/.vim/bundle":
    ensure => directory,
    mode => '0700',
  }

  vcsrepo { "${path}/.vim/bundle/vundle":
      ensure => 'present',
      provider => 'git',
      source => 'https://github.com/gmarik/vundle',
      user => "${user}",
      group => "${user}",
  }

  vcsrepo { "${path}/.config/awesome":
      ensure => 'present',
      provider => 'git',
      source => 'https://github.com/ahdinosaur/powerarrow',
      user => "${user}",
      group => "${user}",
  }

  vcsrepo { "${path}/.config/xfce4":
      ensure => 'present',
      provider => 'git',
      source => 'https://github.com/ahdinosaur/xfce4-config',
      user => "${user}",
      group => "${user}",
  }

  vcsrepo { "${path}/bin":
      ensure => 'present',
      provider => 'git',
      source => 'https://github.com/ahdinosaur/bin',
      user => "${user}",
      group => "${user}",
  }
  apt::force { 'git-annex':
    release => 'unstable',
    require => Apt::Source['debian_unstable'],
  }
}
