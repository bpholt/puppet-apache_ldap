# ## Define apache_ldap::location
#
# ### Parameters
#
# [*url*]
#   Path on the server that should be protected. See [the Apache HTTPD
#   documentation](http://httpd.apache.org/docs/2.2/mod/core.html#location)
#   for more details on how this works.
#
# [*realm*]
#   The HTTP Basic Auth realm. Generally set as a site default.
#
# [*ldap_url*]
#   URL specifying the LDAP search parameters. Generally set as a site default.
#
# [*clone_groups*]
#   (Optional.) List of distinguished names of LDAP groups that are
#   allowed to clone or pull from the repository.
#
# [*clone_users*]
#   (Optional.) List of distinguished names of LDAP users that are
#   allowed to clone or pull from the repository. If the parameter contains
#   only `valid_user`, any authenticated user will be allowed to clone.
#
# [*push_groups*]
#   (Optional.) List of distinguished names of LDAP groups that are
#   allowed to push to the repository.
#
# [*clone_users*]
#   (Optional.) List of distinguished names of LDAP users that are
#   allowed to push to the repository. If the parameter contains only
#   `valid_user`, any authenticated user will be allowed to push.
#
# [*ldap_bind_dn*]
#   (Optional.) Distinguished name to use in binding to the LDAP server.
#
# [*ldap_bind_password*]
#   (Optional.) Password to use in binding to the LDAP server.
#
# [*conf_file*]
#   (Optional.) Filename where Apache config for this Location should
#   be saved. If unset, the resource `title` will be used, with `/` or `\`
#   replaced with an underscore (`_`), and `.conf` appended.
#
# [*ldap_connection_type*]
#   (Optional.) Override the connection type. Valid values are `NONE`,
#   `SSL`, `TLS`, or `STARTTLS`.
#
define apache_ldap::location (
  $url,
  $realm,
  $ldap_url,
  $clone_groups = [],
  $clone_users = [],
  $push_groups = [],
  $push_users = [],
  $ldap_bind_dn = unset,
  $ldap_bind_password = unset,
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

  if !($ldap_connection_type in ['', 'NONE', 'SSL', 'TLS', 'STARTTLS']) {
    fail('Invalid LDAP Connection Type. Must be one of [NONE | SSL | TLS | STARTTLS].')
  }

  file { $real_conf_file:
    ensure  => present,
    path    => "${apache_ldap::confd_base}/${real_conf_file}",
    content => template('apache_ldap/location.conf.erb'),
  }
}

