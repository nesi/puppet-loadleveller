# Class: loadleveller
#
# This module manages loadleveller
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#

# This file is part of the loadleveller Puppet module.
#
#     The loadleveller Puppet module is free software: you can redistribute it and/or modify
#     it under the terms of the GNU General Public License as published by
#     the Free Software Foundation, either version 3 of the License, or
#     (at your option) any later version.
#
#     The loadleveller Puppet module is distributed in the hope that it will be useful,
#     but WITHOUT ANY WARRANTY; without even the implied warranty of
#     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#     GNU General Public License for more details.
#
#     You should have received a copy of the GNU General Public License
#     along with the loadleveller Puppet module.  If not, see <http://www.gnu.org/licenses/>.

# [Remember: No empty lines between comments and class definition]
class loadleveller(
  $base_url,
  $ibm_java_pkg = 'IBMJava2-AMD64-142-JRE-1.4.2-5.0',
  $ibm_java_url = undef,
  $rhel_dist    = 'RH6-X86_64',
  $arch         = 'x86_64',
  $version      = '4.1.1.1-0',
  $license      = 'full'
){

  $dep_pkgs = ['wget','libXp','libXScrnSaver']

  package{$dep_pkgs: ensure => installed}

  $rpm_version  = "-${rhel_dist}-${version}"
  $rpm_tail     = ".${arch}.rpm"

  $licence_pkg  = "LoadL-${license}-license${rpm_version}"
  $licence_url  = "${base_url}${licence_pkg}${rpm_tail}"

  package{'LoadL_license':
    name      => $licence_pkg,
    ensure    => installed.
    require   => Package['libXP'],
    provider  => rpm,
    source    => $licence_url,
  }

  if $ibm_java_url {
      $rl_ibm_java_url = $ibm_java_url
  } else {
      $rl_ibm_java_url = "${base_url}${ibm_java_pkg}${rpm_tail}"
  }

  package {'ibm_java':
    name      => $ibm_java_pkg,
    ensure    => installed,
    source    => $rl_ibm_java_url,
    provider  => rpm
  }

}
