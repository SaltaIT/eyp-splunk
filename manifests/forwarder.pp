class splunk::forwarder(
                            $manage_package              = true,
                            $package_ensure              = 'installed',
                            $manage_service              = true,
                            $manage_docker_service       = true,
                            $service_ensure              = 'running',
                            $service_enable              = true,
                            $package_source_url          = undef,
                            $srcdir                      = '/usr/local/src',
                            $deployment_server           = undef,
                            $os_user                     = undef,
                            $phone_home_interval_in_secs = undef,
                          ) inherits splunk{

  class { '::splunk::forwarder::install': } ->
  class { '::splunk::forwarder::config': } ~>
  class { '::splunk::forwarder::service': } ->
  Class['::splunk::forwarder']

}
