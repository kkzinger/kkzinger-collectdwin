# config.pp
class collectdwin::config (
  $config = $::collectdwin::params::config,
  $debug_level = $::collectdwin::params::debug_level,
  $config_file_win_perfcounter = $::collectdwin::params::config_file_win_perfcounter,
  $config_file_write_http = $::collectdwin::params::config_file_write_http,
  $config_file_general = $::collectdwin::params::config_file_general,
  $service_state = $::collectdwin::params::service_state,
  $config_write_http= $::collectdwin::params::config_write_http,
  $plugin_writehttp = $::collectdwin::params::plugin_writehttp,
  $plugin_amqp = $::collectdwin::params::plugin_amqp,
  $plugin_console = $::collectdwin::params::plugin_console,
  $plugin_statsd = $::collectdwin::params::plugin_statsd,
  $plugin_winperfcounter = $::collectdwin::params::plugin_winperfcounter,
  $scan_interval = $::collectdwin::params::scan_interval,
)inherits ::collectdwin::params{

  service{ 'CollectdWinService':
    ensure  => $service_state,
    require => Package['collectdwin'],
  }

  #config section for general configuration
  file { $config_file_general :
    ensure  => 'present',
    content => regsubst(template('collectdwin/CollectdWin.config.erb'), '\n', "\r\n", 'EMG'),
    notify  => Service['CollectdWinService'],
  }
  
  # concat section "Windows Performance Counter Plugin" for pre and post snippets of configuration xml file

  concat { $config_file_win_perfcounter :
    mode           => '0775',
    path           => $config_file_win_perfcounter,
    ensure_newline => true,
    notify         => Service['CollectdWinService'],
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
    ensure_newline => true,
    notify         => Service['CollectdWinService'],
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
