class splunk::forwarder::service inherits splunk {

  $is_docker_container_var=getvar('::eyp_docker_iscontainer')
  $is_docker_container=str2bool($is_docker_container_var)

  if( $is_docker_container==false or
      $splunk::forwarder::manage_docker_service)
  {
    if($splunk::forwarder::manage_service)
    {
      service { $splunk::params::forwarder_service_name:
        ensure    => $splunk::forwarder::service_ensure,
        enable    => $splunk::forwarder::service_enable,
        pattern   => 'splunkd',
        hasstatus => true,
      }
    }
  }
}
