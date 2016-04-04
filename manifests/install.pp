class conwin_collectdwin::install (
  $collectdwin_version = $::conwin_collectdwin::params::collectdwin_version,
  $service_state = $::conwin_collectdwin::params::service_state,
)inherits ::conwin_collectdwin::params{

  package{ 'collectdwin':
    ensure   => $collectdwin_version,  
    provider => 'chocolatey',
  }
  
  service{ 'CollectdWinService':
    ensure  => $service_state,
    require => Package['collectdwin'],
  }

}
