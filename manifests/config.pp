class collectdwin::config (
  $config = $::collectdwin::params::config,
  $debug_level = $::collectdwin::params::debug_level,
  $config_file_win_perfcounter = $::collectdwin::params::config_file_win_perfcounter,
  $config_file_write_http_ = $::collectdwin::params::config_file_win_perfcounter,
  $service_state = $::collectdwin::params::service_state,
  $config_write_http= $::collectdwin::params::config_write_http,
)inherits ::collectdwin::params{

  service{ 'CollectdWinService':
    ensure  => $service_state,
    require => Package['collectdwin'],
  }

#  file { $config_file_win_perfcounter:
#    ensure  => 'present',
#    content => regsubst(template('collectdwin/WindowsPerformanceCounter.config.erb'), '\n', "\r\n", 'EMG'),
#    notify  => Service['CollectdWinService'],
#  }
  concat { 'performance-counter-config':
    path => $config_file_win_perfcounter,
    warn => true, 
  }

  concat::fragment {'performance-counter-config_pre':
    target  => $config_file_win_perfcounter,
    content => regsubst(template('collectdwin/WindowsPerformanceCounter.config_pre.erb'), '\n', "\r\n", 'EMG'),
    order   => '01',
  }

  concat::fragment {'performance-counter-config_post':
    target  => $config_file_win_perfcounter,
    content => regsubst(template('collectdwin/WindowsPerformanceCounter.config_post.erb'), '\n', "\r\n", 'EMG'),
    order   => '15',
  }

  file { $config_file_write_http:
    ensure  => 'present',
    content => regsubst(template('collectdwin/WriteHttp.config.erb'), '\n', "\r\n", 'EMG'),
    notify  => Service['CollectdWinService'],
  }

}
