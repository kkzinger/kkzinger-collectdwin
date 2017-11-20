# Class: collectdwin::config
# ===========================
#
# This class writes configuration to collectdwin and refreshes the service
# if needed.
#
# Parameters
# ----------
#
# Examples
# --------
#
# Authors
# -------
#
# Gerold Katzinger <gerold@katzinger.info>
#
# Copyright
# ---------
#
# Copyright 2016 Gerold Katzinger

class collectdwin::config (
  $debug_level                 = $::collectdwin::debug_level,
  $config_file_win_perfcounter = $::collectdwin::config_file_winperfcounter,
  $config_file_write_http      = $::collectdwin::config_file_writehttp,
  $config_file_general         = $::collectdwin::config_file_general,
  $config_file_nlog            = $::collectdwin::config_file_nlog,
  $service_state               = $::collectdwin::service_state,
  $plugin_writehttp            = $::collectdwin::plugin_writehttp,
  $plugin_amqp                 = $::collectdwin::plugin_amqp,
  $plugin_console              = $::collectdwin::plugin_console,
  $plugin_statsd               = $::collectdwin::plugin_statsd,
  $plugin_winperfcounter       = $::collectdwin::plugin_winperfcounter,
  $scan_interval               = $::collectdwin::scan_interval,
  $hostname                    = $::collectdwin::hostname,
)inherits ::collectdwin::params{

  service{ 'CollectdWinService':
    ensure  => $service_state,
    require => Package['collectdwin'],
  }


  if $hostname != undef {
    $_hostname = "HostName=\"${hostname}\""
  } else {
    $_hostname = ''
  }

  #config section for general configuration
  file { $config_file_general :
    ensure  => 'present',
    content => regsubst(template('collectdwin/CollectdWin.config.erb'), '\n', "\r\n", 'EMG'),
    notify  => Service['CollectdWinService'],
  }

  #config section for nlog configuration
  file { $config_file_nlog :
    ensure  => 'present',
    content => regsubst(template('collectdwin/nlog.config.erb'), '\n', "\r\n", 'EMG'),
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
