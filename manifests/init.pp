# == Class: winlogon
#
# Full description of class winlogon here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { winlogon:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
#
class winlogon (
  $ensure,
  $caption,
  $message,
) {
  case $ensure {
    present: {
      registry::value { 'Manage Winlogon Caption' :
        key   => 'HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon',
        value => 'LegalNoticeCaption',
        type  => string,
        data  => $caption,
      }
      registry::value { 'Manage Winlogon Message' :
        key   => 'HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon',
        value => 'LegalNoticeText',
        type  => string,
        data  => $message,
      }
    }
    absent: {
      registry::value { 'Manage Winlogon Caption' :
        key   => 'HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon',
        value => 'LegalNoticeCaption',
        type  => string,
        data  => '',
      }
      registry::value { 'Manage Winlogon Message' :
        key   => 'HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon',
        value => 'LegalNoticeText',
        type  => string,
        data  => '',
      }
    }
    default: {
      fail('You must supply ensure status - present or absent...')
    }
  }
}
