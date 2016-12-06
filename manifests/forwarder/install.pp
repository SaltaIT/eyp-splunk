class splunk::forwarder::install inherits splunk {

  if($splunk::forwarder::manage_package)
  {
    package { $splunk::params::forwarder_package_name:
      ensure => $splunk::forwarder::package_ensure,
    }
  }

}
