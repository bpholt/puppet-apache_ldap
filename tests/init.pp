# The baseline for module testing used by Puppet Labs is that each manifest
# should have a corresponding test manifest that declares that class or defined
# type.
#

Apache_ldap::Location {
  ldap_url           => 'ldap://ldap.example.com:389/OU=ORG,DC=example,DC=com?sAMAccountName?sub?(objectClass=*)',
  ldap_bind_dn       => 'cn=user,DC=example,DC=com',
  ldap_bind_password => 'p@ssw0rd',
}

include apache_ldap

apache_ldap::location { 'test':
  url          => '/repository',
  realm        => 'My Repositories',
  clone_groups => [],
  clone_users  => [],
  push_groups  => [],
  push_users   => [],
}


