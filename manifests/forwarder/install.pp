class splunk::forwarder::install inherits splunk {

  Exec {
    path => '/bin:/sbin:/usr/bin:/usr/sbin',
  }

  if($splunk::forwarder::manage_package)
  {
    if($splunk::forwarder::package_source_url==undef)
    {
      fail('undefined package source, not able to install splunk forwarder')
    }
    else
    {
      exec { 'eyp-splunk forwarder which wget':
        command => 'which wget',
        unless  => 'which wget',
      }

      exec { "wget splunk forwarder ${splunk::params::srcdir} ${splunk::forwarder::package_source_url}":
        command => "wget ${splunk::forwarder::package_source_url} -O ${srcdir}/splunkforwarder.${splunk::params::package_provider}",
        creates => "${splunk::forwarder::srcdir}/splunkforwarder.${splunk::params::package_provider}",
        require => Exec['eyp-splunk forwarder which wget'],
      }

      package { $splunk::params::forwarder_package_name:
        ensure   => $splunk::forwarder::package_ensure,
        provider => $splunk::params::package_provider,
        source   => "${splunk::forwarder::srcdir}/splunkforwarder.${splunk::params::package_provider}",
        require  => Exec["wget splunk forwarder ${splunk::params::srcdir} ${splunk::forwarder::package_source_url}"],
      }
    }
  }

}
