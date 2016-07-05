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
#   Collectdwin uses a windows service to run measurements as daemon. This parameter controls if the service should be in 'running' or 'stopped' status. Default: running
#
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'collectdwin_':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
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
  $plugin_amqp = $::collectdwin::params::plugin_aqmp,
  $plugin_console = $::collectdwin::params::plugin_console,
  $plugin_statsd = $::collectdwin::params::plugin_statsd,
  $plugin_winperfcounter = $::collectdwin::params::plugin_winperfcounter,
  $scan_interval = $::collectdwin::params::scan_interval,
  $config_file_writehttp = $::collectdwin::param::config_file_writehttp,
  $config_file_winperfcounter = $::collectdwin::params::config_file_winperfcounter,
  $config_file_general = $::collectdwin::params::config_file_general,
){
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
