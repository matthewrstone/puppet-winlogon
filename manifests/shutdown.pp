# Winlogon Shutdown settings
define winlogon::shutdown {
validate_bool($::winlogon::shutdown)
  case $::winlogon::shutdown {
    true    : { $shutdown_data=1 }
    false   : { $shutdown_data=0 }
    default : { fail('You must specify shutdown status...true or false') }
  }

  registry::value { 'Manage Shutdown with Logon' :
    key   => 'HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon',
    value => 'ShutdownWithoutLogon',
    type  => string,
    data  => $shutdown_data,
  }
}
