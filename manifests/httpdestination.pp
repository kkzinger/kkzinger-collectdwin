## 

define collectdwin::httpdestination (
  $node_name,
  $url,
  $timeout,
  $batch_size,
  $max_idle_time,
  $proxy_enable,
  $proxy_url,
){

  require ::collectdwin::params
  
  $config_file_write_http = $::collectdwin::params::config_file_write_http
  concat::fragment { $node_name:
    target  => $config_file_write_http,
    content => regsubst(template('collectdwin/WriteHttp.config.erb'), '\n', "\r\n", 'EMG'),
    order   => '10',
  }

}

