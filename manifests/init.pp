# winlogon
#
# Description: Manages the Windows Logon message
#
# Usage:
#
#   ensure  => present | absent  # set the ensure status
#   caption => 'your caption message here' # the caption, defaults to $title
#   message => 'your message here' # the message, defaults to $title
#
# If you need multiple paragraphs, you can use an array for the message, or use double quotes and the \n escape character in the message string.
#
# Examples: 
#
# Set caption and message to "AUTHORIZED USERS ONLY":
#
#   winlogon { 'AUTHORIZED USERS ONLY' : }
#
# Set caption and a separate message:
#   
#   winlogon { 'AUTHORIZED USERS ONLY' :
#     message => 'This system is for authorized users only.  All logins will be reported',
#   }
#
# Set caption and a really long message :
#
#   winlogon { 'AUTHORIZED USERS ONLY' :
#     message => ['Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec a diam lectus.',
#      'Sed sit amet ipsum mauris. Maecenas congue ligula ac quam viverra nec consectetur ante hendrerit.',
#      'Donec et mollis dolor. Praesent et diam eget libero egestas mattis sit amet vitae augue.'],
#   }
#
# === Copyright
#
# Copyright 2014 Matthew Stone, unless otherwise noted.
#
define winlogon (
  $ensure  = present,
  $caption = $title,
  $message = $title,
) {

  case is_array($message) {
    true    : { $logon_message = join($message,"\n\n") }
    false   : { $logon_message = $message }
    default : { fail('message attribute should be true or false') }
  }
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
        data  => $logon_message,
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
