# Class: collectdwin
# ===========================
#
# This class installs the collectdwin package
#
# Parameters
# ----------
#
# Examples
# --------
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

class collectdwin::install (
  $collectdwin_version = $::collectdwin::collectdwin_version,
){

  package{ 'collectdwin':
    ensure   => $collectdwin_version,
    provider => 'chocolatey',
  }
}
