# Class: collectdwin::params
# ===========================
#
# This class defines some default values
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

class collectdwin::params {

  $collectdwin_version = undef
  $service_state = 'running'
  $debug_level = 'Info'
  $config_file_writehttp ='C:/Program Files/Bloomberg LP/CollectdWin/config/WriteHttp.config'
  $config_file_winperfcounter = 'C:/Program Files/Bloomberg LP/CollectdWin/config/WindowsPerformanceCounter.config'
  $config_file_general = 'C:/Program Files/Bloomberg LP/CollectdWin/config/CollectdWin.config'
  $config_file_nlog = 'C:/Program Files/Bloomberg LP/CollectdWin/config/nlog.config'

  $plugin_writehttp = true
  $plugin_amqp = false
  $plugin_console = true
  $plugin_statsd = false
  $plugin_winperfcounter = true
  $scan_interval = '10'
}
