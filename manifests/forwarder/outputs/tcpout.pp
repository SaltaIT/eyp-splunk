#
# http://docs.splunk.com/Documentation/SplunkCloud/6.6.0/Forwarding/Configureforwarderswithoutputs.confd
#
# [tcpout]
# defaultGroup = default-autolb-group
#
# [tcpout:default-autolb-group]
# server = {{ splunk_server_ip }}:9997
#
# [tcpout-server://{{ splunk_server_ip }}:9997]
#
# puppet2sitepp @splunkfwdtcpouts
define splunk::forwarder::outputs::tcpout (
                                            $target_group   = $name,
                                            $set_as_default = false,
                                            $servers        = [],
                                          ) {

  if(!defined(Concat['/opt/splunkforwarder/etc/system/local/outputs.conf']))
  {
    concat { '/opt/splunkforwarder/etc/system/local/outputs.conf':
      ensure  => 'present',
      owner   => 'splunk',
      group   => 'splunk',
      mode    => '0644',
      notify  => Class['splunk::forwarder::service'],
      require => Class['splunk::forwarder::install'],
    }
  }

  if($set_as_default)
  {
    concat::fragment{ 'outputs.conf global settings: default':
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
