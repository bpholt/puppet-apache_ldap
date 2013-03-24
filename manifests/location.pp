# ### Define apache_ldap::location
#
#
define apache_ldap::location (
  $url,
  $realm,
  $clone_groups,
  $clone_users,
  $push_groups,
  $push_users,
  $ldap_url,
  $ldap_bind_dn,
  $ldap_bind_password,
  $conf_file = "${title}.conf",
) {
  $confd_base = '/etc/httpd/conf.d'

  file { $conf_file:
    ensure  => present,
    path    => "${confd_base}/${conf_file}",
    content => template('apache_ldap/location.conf.erb'),
  }
}

