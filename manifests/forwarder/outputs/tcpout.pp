#
# [tcpout]
# defaultGroup = default-autolb-group
#
# [tcpout:default-autolb-group]
# server = {{ splunk_server_ip }}:9997
#
# [tcpout-server://{{ splunk_server_ip }}:9997]
#
define splunk::forwarder::outputs::tcpout (
                                            $target_group   = $name,
                                            $set_as_default = false,
                                            $servers        = {},
                                          ) {
  #
  validate_hash($servers)
  
  if(!defined(Concat['/opt/splunkforwarder/etc/system/local/outputs.conf']))
  {
    concat { '/opt/splunkforwarder/etc/system/local/outputs.conf':
      ensure => 'present',
      owner  => 'splunk',
      group  => 'splunk',
      mode   => '0644',
      notify => Class['splunk::forwarder::service'],
    }
  }

  if($set_as_default)
  {
    concat::fragment{ "outputs.conf default":
      target  => '/opt/splunkforwarder/etc/system/local/outputs.conf',
      order   => '00',
      content => template("${module_name}/forwarder/outputs/default.erb"),
    }
  }

  concat::fragment{ "outputs.conf ${target_group}":
    target  => '/opt/splunkforwarder/etc/system/local/outputs.conf',
    order   => "${target_group}_00",
    content => template("${module_name}/forwarder/outputs/targetgroup.erb"),
  }
}
