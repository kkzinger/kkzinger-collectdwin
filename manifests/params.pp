class conwin_collectdwin::params {

  $collectdwin_version = $::conwin_collectdwin::collectdwin_version
  $service_state = $::conwin_collectdwin::service_state
  $debug_level = $::conwin_collectdwin::debug_level
  $config = $::conwin_collectdwin::config
  $config_file_write_http ='C:\Program Files\Bloomberg LP\CollectdWin\config\WriteHttp.config'
  $config_file_win_perfcounter = 'C:\Program Files\Bloomberg LP\CollectdWin\config\WindowsPerformanceCounter.config'
  $config_write_http = $::conwin_collectdwin::config_write_http
  $config_perfcounters = [
    {
      category          => 'Processor',
      name              => '% Processor Time',
      instance          => '_Total',
      cd_plugin         => 'cpu',
      cd_plugininstance => 'cpu-average',
      cd_type           => 'cpu',
      cd_typeinstance   => 'processor',
    },
    {
      category          => 'Memory',
      name              => 'Available Bytes',
      instance          => '',
      cd_plugin         => 'memory',
      cd_plugininstance => '',
      cd_type           => 'memory',
      cd_typeinstance   => 'free',
    },
    {
      category          => 'Network Interface',
      name              => 'Packets Received/Sec,Pakets Sent/Sec',
      instance          => '*',
      cd_plugin         => 'interface',
      cd_plugininstance => '',
      cd_type           => 'if_packets',
      cd_typeinstance   => '',
    },

  ]
#  $config_write_http = [
#    {
#      node_name     => 'stunnel-to-lab-perfmon-collector',
#      url           => 'http://localhost:9223/collectd',
#      timeout       => '100',
#      batch_size    => '30',
#      max_idle_time => '600000',
#      proxy_enable  => 'false',
#      proxy_url     => '',
#    },
#  ]
}
