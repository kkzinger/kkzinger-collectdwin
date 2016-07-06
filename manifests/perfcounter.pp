# Define: collectdwin::perfcounter
# ===========================
#
# This define is able to add single performance counters to the windows performance
# counter plugin configuration.
#
# Parameters
# ----------
#
# [*category*]
#   Windows performance counter category
#
# [*counter_name*]
#   Windows performance counter name
#
# [*instance*]
#   Windows performance counter instance
#
# [*cd_plugin*]
#   collectd plugin name. The output is designed to provide collectd aware output.
#
# [*cd_plugininstance*]
#   collectd plugin instance
#
# [*cd_type*]
#   collectd type
#
# [*cd_typeinstance*]
#   collectd type instance
#
# Examples
# --------
#
# ::collectdwin::perfcounter{
#   'cpu_foo':
#              category          => 'Processor',
#              counter_name      => '% Processor Time',
#              instance          => '_Total',
#              cd_plugin         => 'cpu',
#              cd_plugininstance => 'cpu-average',
#              cd_type           => 'cpu',
#              cd_typeinstance   => 'processor';
#   'mem_foo':
#              category          => 'Memory',
#              counter_name      => 'Available Bytes',
#              instance          => '',
#              cd_plugin         => 'memory',
#              cd_plugininstance => '',
#              cd_type           => 'memory',
#              cd_typeinstance   => 'free';
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

define collectdwin::perfcounter (
  $category,
  $counter_name,
  $instance,
  $cd_plugin,
  $cd_plugininstance,
  $cd_type,
  $cd_typeinstance,
){

  #Parameter Validation
  validate_string($category)
  validate_string($counter_name)
  validate_string($instance)
  validate_string($cd_plugin)
  validate_string($cd_plugininstance)
  validate_string($cd_type)
  validate_string($cd_typeinstance)

  #collectdwin class is needed to be able to add performance counter to configuration file
  include ::collectdwin
  $config_file_winperfcounter = $::collectdwin::config_file_winperfcounter

  concat::fragment { "${counter_name}${instance}":
    target  => $config_file_winperfcounter,
    content => regsubst(template('collectdwin/WindowsPerformanceCounter.config.erb'), '\n', "\r\n", 'EMG'),
    order   => '10',
  }

}

