# Define: collectdwin::httpdestination
# ===========================
#
# With this define it is possible to add destinations where the metrics
# should be sent via http-post. The configuration is written to the writehttp plugin
# configuration file
#
# Parameters
# ----------
#
# [*node_name*]
#   Sets a name for the destination
#
# [*url*]
#   Path to destination (supports https)
#
# [*timeout*]
#   Timeout for the HTTP POST in milliseconds
#
# [*batch_size*]
#   Number of metrics per HTTP POST.
#
# [*max_idle_time*]
#   Maximum idle time for TCP connection in milliseconds
#
# [*proxy_enable*]
#   Flag to enable HTTP Proxy
#
# [*proxy_url*]
#   If Proxy is enabled through proxy_enable this parameter has to provide a
#   proxy URL
#
# Examples
# --------
# ::collectdwin::httpdestination{
#   'graphite-flask':
#       node_name     => 'graphite-flask-bridge',
#       url           => 'https://192.168.1.1:8888/',
#       timeout       => '100',
#       batch_size    => '30',
#       max_idle_time => '600000',
#       proxy_enable  => false,
#       proxy_url     => '',
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

define collectdwin::httpdestination (
  $node_name,
  $url,
  $timeout,
  $batch_size,
  $max_idle_time,
  $proxy_enable,
  $proxy_url,
  $username = undef,
  $password = undef
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
  
  if $username != undef {
    $_username = "UserName=\"${username}\""
  } else {
    $_username = ''
  }

  if $password != undef {
    $_password = "Password=\"${password}\""
  } else {
    $_password = ''
  }


  concat::fragment { $node_name:
    target  => $config_file_writehttp,
    content => regsubst(template('collectdwin/WriteHttp.config.erb'), '\n', "\r\n", 'EMG'),
    order   => '10',
  }

}

