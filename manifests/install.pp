##
class collectdwin::install (
  $collectdwin_version = $::collectdwin::collectdwin_version,
){

  package{ 'collectdwin':
    ensure   => $collectdwin_version,
    provider => 'chocolatey',
  }
}
