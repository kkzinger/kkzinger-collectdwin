class collectdwin::install (
  $collectdwin_version = $::collectdwin::params::collectdwin_version,
#  $service_state = $::collectdwin::params::service_state,
)inherits ::collectdwin::params{

  package{ 'collectdwin':
    ensure   => $collectdwin_version,  
    provider => 'chocolatey',
  }
  
#  service{ 'CollectdWinService':
#    ensure  => $service_state,
#    require => Package['collectdwin'],
#  }

}
