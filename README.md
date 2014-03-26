Proftp module for Puppet
==========================

Description
-----------

Puppet module for configuring proftp.

Usage
-----

The simplest use case is to use all of the configurations in
the default collectd.conf file shipped with collectd. This can
be done by simply including the class:

```puppet
class { 'proftp':
  conf => "puppet://modules/role/ftpserver/proftpd.conf",
}
```

##Limitations

This module has been tested on Ubuntu Precise

