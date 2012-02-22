class proftpd {

  user { 'ftp':
    ensure   => 'present',
    comment  => 'Anonymous Ftp',
    gid      => '1',
    home     => '/u/ftp',
    password => '*',
    shell    => '/bin/sh',
    uid      => '8',
  }

  File {
    owner     => root,
    group     => root,
    mode      => 644,
  }

  file {
    "proftpd-preseed":
      path    => "/var/cache/debconf/proftpd",
      source  => "puppet://$server/modules/proftpd/proftpd-preseed";

    "/etc/proftpd/proftpd.conf":
      source  => "puppet://$server/modules/proftpd/etc/proftpd/proftpd.conf";

    "/etc/pam.d/proftpd":
      source  => "puppet://$server/modules/proftpd/etc/pam.d/proftpd";
   }

  package { "proftpd":
    ensure    => present,
    require   => File["proftpd-preseed"]
  }

  service { "proftpd":
    ensure    => running,
    enable    => true,
    subscribe => File["/etc/proftpd/proftpd.conf"],
    require   => File["/etc/pam.d/proftpd"]
  }

}
