node default {
  # Setup pre and post run stages
  # Typically these are only needed in special cases but are good to have
  stage { ['pre', 'post']: }
  Stage['pre'] -> Stage['main'] -> Stage['post']

  # Install text editors
  package { 'vim-enhanced': ensure => installed }
  package { 'emacs':        ensure => installed }

  class { 'splunk':
    type => 'indexer',
  }
  class { 'splunk::inputs':
    input_hash =>  { 'splunktcp://50514' => {} }
  }
  splunk::ta::files { 'Splunk_TA_nix': }
 }
# vim: set ft=puppet ts=2 sw=2 ei:
