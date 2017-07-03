#
# [monitor:///var/log/messages
# index = system
# sourcetype =  messages
#
#
#
# [monitor:///var/log/audit/audit.log]
# index = auditd
# sourcetype = linux:audit
#
# puppet2sitepp @splunkfwdmonitors
define splunk::forwarder::monitor (
                                    $index,
                                    $sourcetype,
                                    $path  = $name,
                                    $order = '00',
                                  ) {
  if(!defined(Concat['/opt/splunkforwarder/etc/system/local/inputs.conf']))
  {
    concat { '/opt/splunkforwarder/etc/system/local/inputs.conf':
      ensure => 'present',
      owner  => 'splunk',
      group  => 'splunk',
      mode   => '0644',
      notify => Class['splunk::forwarder::service'],
    }
  }

  concat::fragment{ "inputs.conf ${path}":
    target  => '/opt/splunkforwarder/etc/system/local/inputs.conf',
    order   => $order,
    content => template("${module_name}/forwarder/input/monitor.erb"),
  }
}
