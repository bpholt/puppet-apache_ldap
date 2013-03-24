# == Class: apache_ldap
#
# === Authors
#
# Brian P. Holt <bholt@planetholt.com>
#
# === Copyright
#
# Copyright 2013 Brian P. Holt, unless otherwise noted.
#
class apache_ldap (
  $ldap_shared_cache_size = 500000,
  $ldap_cache_entries = 1024,
  $ldap_cache_ttl = 600,
  $ldap_op_cache_entries = 1024,
  $ldap_op_cache_ttl = 600,
) {
  file { 'ldap.conf':
    ensure  => present,
    path    => '/etc/httpd/conf.d/ldap.conf',
    content => template('apache_ldap/ldap.conf.erb'),
  }
}

