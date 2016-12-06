class splunk::service inherits splunk {

  #
  validate_bool($splunk::manage_docker_service)
  validate_bool($splunk::manage_service)
  validate_bool($splunk::service_enable)

  validate_re($splunk::service_ensure, [ '^running$', '^stopped$' ], "Not a valid daemon status: ${splunk::service_ensure}")

  $is_docker_container_var=getvar('::eyp_docker_iscontainer')
  $is_docker_container=str2bool($is_docker_container_var)

  if( $is_docker_container==false or
      $splunk::manage_docker_service)
  {
    if($splunk::manage_service)
    {
      service { $splunk::params::service_name:
        ensure => $splunk::service_ensure,
        enable => $splunk::service_enable,
      }
    }
  }
}
