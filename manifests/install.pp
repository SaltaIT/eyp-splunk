class splunk::install inherits splunk {

  if($splunk::manage_package)
  {
    package { $splunk::params::package_name:
      ensure => $splunk::package_ensure,
    }
  }

}
