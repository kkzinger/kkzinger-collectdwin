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

  #Parameter Validation
  validate_string($node_name)
  validate_string($url)
  validate_integer($timeout)
  validate_integer($batch_size)
  validate_integer($max_idle_time)
  validate_bool($proxy_enable)
  if($proxy_enable == true)
  {
    validate_string($proxy_url)
  }

  #The collectdwin class has to be present in first place to be able to add a http destination
  include ::collectdwin
  $config_file_writehttp = $::collectdwin::config_file_writehttp
  
  concat::fragment { $node_name:
    target  => $config_file_writehttp,
    content => regsubst(template('collectdwin/WriteHttp.config.erb'), '\n', "\r\n", 'EMG'),
    order   => '10',
  }

}

