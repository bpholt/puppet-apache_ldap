puppet-apache_ldap
===========================

Manages Apache conf files for Location directives that need LDAP security.

### Example

    # Set site defaults for common properties
    Apache_ldap::Location {
      ldap_url           => 'ldap://ldap.example.com:389/OU=ORG,DC=example,DC=com?sAMAccountName?sub?(objectClass=*)',
      ldap_bind_dn       => 'cn=user,DC=example,DC=com',
      ldap_bind_password => 'p@ssw0rd',
    }
    
    include apache_ldap
    
    apache_ldap::location { 'test':
      url          => '/repository',
      realm        => 'My Repositories',
      clone_groups => ['clone_group1','clone_group2',],
      clone_users  => ['clone_user1','clone_user2',],
      push_groups  => ['push_group1','push_group2',],
      push_users   => ['push_user1','push_user2',],
    }

