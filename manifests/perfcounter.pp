##

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

