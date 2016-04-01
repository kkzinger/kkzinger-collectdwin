class conwin_collectdwin::config (
  $config = $::conwin_collectdwin::params::config,
  $debug_level = $::conwin_collectdwin::params::debug_level,
  $config_file_win_perfcounter = $::conwin_collectdwin::params::config_file_win_perfcounter,
  $config_file_write_http_ = $::conwin_collectdwin::params::config_file_win_perfcounter,
)inherits ::conwin_collectdwin::params{

  file { $config_file_win_perfcounter:
    ensure    => 'present',
    content   => regsubst(template('conwin_collectdwin/WindowsPerformanceCounter.config.erb'), '\n', '\r\n', 'EMG'),
    notify  => Service['CollectdWinService'],
  }
  
  file { $config_file_write_http:
    ensure    => 'present',
    content   => regsubst(template('conwin_collectdwin/WriteHttp.config.erb'), '\n', '\r\n', 'EMG'),
    notify  => Service['CollectdWinService'],
  }

}
