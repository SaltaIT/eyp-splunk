class splunk::forwarder::config inherits splunk {

  if($splunk::forwarder::deployment_server==undef)
  {
      $deployment_ensure='absent'
  }
  else
  {
    $deployment_ensure='present'
  }

  file { '/opt/splunkforwarder/etc/system/local/deploymentclient.conf':
    ensure  => $deployment_ensure,
    owner   => 'splunk',
    group   => 'splunk',
    mode    => '0644',
    content => template("${module_name}/forwarder/deploymentclient.erb"),
  }

  file { '/opt/splunkforwarder/etc/splunk-launch.conf':
    ensure  => 'present',
    owner   => 'splunk',
    group   => 'splunk',
    mode    => '0644',
    content => template("${module_name}/forwarder/splunklaunch.erb"),
  }

}
