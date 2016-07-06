# Class: collectdwin
# ===========================
#
# This class enables the management of collectdwin on Windows Hosts
#
# Parameters
# ----------
#
# Document parameters here.
#
# [*collectdwin_version*]
#   Version of collectdwin chocolatey package
#
# [*debug_level*]
#   Defines logfile verbosity level of collectdwin (Trace, Debug, Info, Warn, Error and Fatal) Default: Info
#
# [*service_state*]
#   Collectdwin uses a windows service to run measurements as daemon.
#   This parameter controls if the service should be in 'running' or 'stopped' status. Default: running
#
# [*plugin_writehttp*]
#   This flag enables the writehttp plugin of collectdwin if set to true
#
# [*plugin_amqp*]
#   This flag enables the amqp plugin of collectdwin if set to true
#
# [*plugin_console*]
#   This flag enables the console plugin of collectdwin if set to true
#
# [*plugin_statsd*]
#   This flag enables the statsd plugin of collectdwin if set to true
#
# [*plugin_winperfcounter*]
#   This flag enables the windows performance counter plugin of collectdwin if set to true
#
# [*scan_interval*]
#   The value of this parameter configures the meassurement interval of collectdwin in seconds
#
# [*config_file_writehttp*]
#   Absolute Path of configuration file for writehttp plugin
#
# [*config_file_winperfcounter*]
#   Absolute Path of configuration file for windows performance counter plugin
#
# [*config_file_general*]
#   Absolute Path to general configuration file of collectdwin
#
# Examples
# --------
#
# class { 'collectdwin_':
#   collectdwin_version => '0.5.14',
#   debug_level         => 'Trace',
# }
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
#
class collectdwin (
  $collectdwin_version = $::collectdwin::params::collectdwin_version,
  $debug_level = $::collectdwin::params::debug_level,
  $service_state = $::collectdwin::params::service_state,
  $plugin_writehttp = $::collectdwin::params::plugin_writehttp,
  $plugin_amqp = $::collectdwin::params::plugin_amqp,
  $plugin_console = $::collectdwin::params::plugin_console,
  $plugin_statsd = $::collectdwin::params::plugin_statsd,
  $plugin_winperfcounter = $::collectdwin::params::plugin_winperfcounter,
  $scan_interval = $::collectdwin::params::scan_interval,
  $config_file_writehttp = $::collectdwin::params::config_file_writehttp,
  $config_file_winperfcounter = $::collectdwin::params::config_file_winperfcounter,
  $config_file_general = $::collectdwin::params::config_file_general,
)inherits ::collectdwin::params{

  #Parameter Validation
  validate_re($collectdwin_version,'^(\d*\.){2}\d*$')
  validate_re($debug_level,['^Trace$','^Debug$','^Info$','^Warn$','^Error$','^Fatal$'])
  validate_re($service_state,'^(running|stopped)$')
  validate_bool($plugin_amqp)
  validate_bool($plugin_console)
  validate_bool($plugin_statsd)
  validate_bool($plugin_winperfcounter)
  validate_absolute_path($config_file_writehttp)
  validate_absolute_path($config_file_winperfcounter)
  validate_absolute_path($config_file_general)
  validate_integer($scan_interval)


  anchor{'::collectdwin::begin':} ->
  class{'::collectdwin::install':} ->
  class{'::collectdwin::config':} ->
  anchor{'::collectdwin::end':}
}
