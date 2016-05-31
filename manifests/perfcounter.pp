## 

define collectdwin::perfcounter (
  $category,
  $counter_name,
  $instance,
  $cd_plugin,
  $cd_plugininstance,
  $cd_type,
  $cd_typeinstance,
  $config_file_win_perfcounter = $::collectdwin::params::config_file_win_perfcounter, 
)inherits ::collectdwin::params{

  ## Funktion zum hinzufügen von einem concat fragment zum perfcounter xml
  concat::fragment { $name:
    target => $config_file_win_perfcounter,
    order  => '10',
  }

}
