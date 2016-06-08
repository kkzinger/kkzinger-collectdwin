class collectdwin::params {

  $collectdwin_version = $::collectdwin::collectdwin_version
  $service_state = $::collectdwin::service_state
  $debug_level = $::collectdwin::debug_level
  $config = $::collectdwin::config
  $config_file_write_http ='C:/Program Files/Bloomberg LP/CollectdWin/config/WriteHttp.config'
  $config_file_win_perfcounter = 'C:/Program Files/Bloomberg LP/CollectdWin/config/WindowsPerformanceCounter.config'
  $config_file_general = 'C:/Program Files/Bloomberg LP/CollectdWin/config/CollectdWin.config'
  $plugin_writehttp = $::collectdwin::plugin_writehttp
  $plugin_amqp = $::collectdwin::plugin_aqmp
  $plugin_console = $::collectdwin::plugin_console
  $plugin_statsd = $::collectdwin::plugin_statsd
  $plugin_winperfcounter = $::collectdwin::plugin_winperfcounter
  $scan_interval = $::collectdwin::scan_interval




}
