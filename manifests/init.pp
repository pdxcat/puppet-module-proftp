class proftp (
  $conf = "puppet://$server/modules/proftp/etc/proftpd/proftpd.conf"
) {

  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  file { "proftpd-preseed":
    path    => "/var/cache/debconf/proftpd",
    source  => "puppet://$server/modules/proftp/proftpd-preseed";
  }

  file { "/etc/proftpd/proftpd.conf":
    source  => $conf;
  }

  file { "/etc/pam.d/proftpd":
    source  => "puppet://$server/modules/proftp/etc/pam.d/proftpd";
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
