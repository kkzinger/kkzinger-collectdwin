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

  require ::collectdwin::params
  
  $config_file_win_perfcounter = $::collectdwin::params::config_file_win_perfcounter
  concat::fragment { "${counter_name}${instance}":
    target  => $config_file_win_perfcounter,
    content => regsubst(template('collectdwin/WindowsPerformanceCounter.config.erb'), '\n', "\r\n", 'EMG'),
    order   => '10',
  }

}

