# == Class: apache_ldap
#
# === Parameters
#
# [*ldap_shared_cache_size*]
#   (Optional.) Specifies the number of bytes to allocate for the shared
#   memory cache.
#
# [*ldap_cache_entries*]
#   (Optional.) Specifies the maximum size of the primary LDAP cache.
#   This cache contains successful search/binds. Set it to 0 to turn off
#   search/bind caching.
#
# [*ldap_cache_ttl*]
#   (Optional.) Specifies the time (in seconds) that an item in the
#   search/bind cache remains valid.
#
# [*ldap_op_cache_entries*]
#   (Optional.) This specifies the number of entries mod_ldap will use to
#   cache LDAP compare operations. Setting it to 0 disables operation caching.
#
# [*ldap_op_cache_ttl*]
#   (Optional.) Specifies the time (in seconds) that entries in the operation
#   cache remain valid.
#
# [*confd_base*]
#   (Optional.) Specifies the directory where Apache .conf files should be
#   placed to be parsed on startup.
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
  $confd_base = '/etc/httpd/conf.d',
) {

  file { 'ldap.conf':
    ensure  => present,
    path    => "${confd_base}/ldap.conf",
    content => template('apache_ldap/ldap.conf.erb'),
  }
}

