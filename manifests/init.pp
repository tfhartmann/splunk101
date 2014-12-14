node default {
  # Setup pre and post run stages
  # Typically these are only needed in special cases but are good to have
  stage { ['pre', 'post']: }
  Stage['pre'] -> Stage['main'] -> Stage['post']

  # Install text editors
  package { 'vim-enhanced': ensure => installed }
  package { 'emacs':        ensure => installed }

  staging::file { 'splunk-6.2.0-237341-linux-2.6-x86_64.rpm':
    source => 'http://download.splunk.com/releases/6.2.0/splunk/linux/splunk-6.2.0-237341-linux-2.6-x86_64.rpm',
    before => Class['splunk']
  }
  class { 'splunk':
    type             => 'indexer',
    package_provider => 'rpm',
    package_source   => '/opt/staging/splunk-6.2.0-237341-linux-2.6-x86_64.rpm',
  }
  class { 'splunk::inputs':
    input_hash =>  { 'splunktcp://50514' => {} }
  }
  service { 'iptables': ensure => 'stopped', }
  #splunk::ta::files { 'Splunk_TA_nix': }
}
# vim: set ft=puppet ts=2 sw=2 ei:
