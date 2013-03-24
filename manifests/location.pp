# ### Define apache_ldap::location
#
#
define apache_ldap::location (
  $url,
  $realm,
  $ldap_url,
  $ldap_bind_dn,
  $ldap_bind_password,
  $clone_groups = [],
  $clone_users = [],
  $push_groups = [],
  $push_users = [],
  $conf_file = undef,
  $ldap_connection_type = '',
) {

  include apache_ldap

  $limit_clone = size($clone_groups) > 0 or size($clone_users) > 0
  $limit_push = size($push_groups) > 0 or size($push_users) > 0

  if $conf_file == undef {
    $title_without_separators = regsubst($title, '[/\\]', '_', 'G')
    $real_conf_file = "${title_without_separators}.conf"
  } else {
    $real_conf_file = $conf_file
  }

  $valid_user_can_clone = $clone_users == 'valid_user'
  $valid_user_can_push = $push_users == 'valid_user'

  file { $real_conf_file:
    ensure  => present,
    path    => "${apache_ldap::confd_base}/${real_conf_file}",
    content => template('apache_ldap/location.conf.erb'),
  }
}

