class collectdwin::config (
  $config = $::collectdwin::params::config,
  $debug_level = $::collectdwin::params::debug_level,
  $config_file_win_perfcounter = $::collectdwin::params::config_file_win_perfcounter,
  $config_file_write_http = $::collectdwin::params::config_file_write_http,
  $service_state = $::collectdwin::params::service_state,
  $config_write_http= $::collectdwin::params::config_write_http,
)inherits ::collectdwin::params{

  service{ 'CollectdWinService':
    ensure  => $service_state,
    require => Package['collectdwin'],
  }

# concat section "Windows Performance Counter Plugin" for pre and post snippets of configuration xml file

  concat { $config_file_win_perfcounter :
    mode           => '0775',
    path           => $config_file_win_perfcounter,
    warn           => true,
    ensure_newline => true,
    notify  => Service['CollectdWinService'],
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

# concat section "Write Http Plugin" for pre and post snippets of configuration xml file

  concat { $config_file_write_http :
    mode           => '0775',
    path           => $config_file_write_http,
    warn           => true,
    ensure_newline => true,
    notify  => Service['CollectdWinService'],
  }

  concat::fragment {'write-http-config_pre':
    target  => $config_file_write_http,
    content => regsubst(template('collectdwin/WriteHttp.config_pre.erb'), '\n', "\r\n", 'EMG'),
    order   => '01',
  }

  concat::fragment {'write-http-config_post':
    target  => $config_file_write_http,
    content => regsubst(template('collectdwin/WriteHttp.config_post.erb'), '\n', "\r\n", 'EMG'),
    order   => '15',
  }


#  file { $config_file_write_http :
#    ensure  => 'present',
#    content => regsubst(template('collectdwin/WriteHttp.config.erb'), '\n', "\r\n", 'EMG'),
#    notify  => Service['CollectdWinService'],
#  }

}
