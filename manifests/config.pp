class conwin_collectdwin::config (
  $config = $::conwin_collectdwin::params::config,
  $debug_level = $::conwin_collectdwin::params::debug_level,
  $config_file_win_perfcounter = $::conwin_collectdwin::params::config_file_win_perfcounter,
  $config_file_write_http_ = $::conwin_collectdwin::params::config_file_win_perfcounter,
  $service_state = $::conwin_collectdwin::params::service_state,
  $config_perfcounters= $::conwin_collectdwin::params::config_perfcounters,
  $config_write_http= $::conwin_collectdwin::params::config_write_http,
)inherits ::conwin_collectdwin::params{

  service{ 'CollectdWinService':
    ensure  => $service_state,
    require => Package['collectdwin'],
  }


  file { $config_file_win_perfcounter:
    ensure  => 'present',
    content => regsubst(template('conwin_collectdwin/WindowsPerformanceCounter.config.erb'), '\n', "\r\n", 'EMG'),
    notify  => Service['CollectdWinService'],
  }
  
  file { $config_file_write_http:
    ensure  => 'present',
    content => template('conwin_collectdwin/WriteHttp.config.erb'),
    notify  => Service['CollectdWinService'],
  }

}
