define ptp4l::instance(
  $single_instance             = true,
  $interface                   = undef,
  $delay_asymmetry             = 0,
  $log_announce_interval       = 3,
  $log_sync_interval           = 0,
  $log_min_delay_req_interval  = 0,
  $log_min_pdelay_req_interval = 0,
  $announce_receipt_timeout    = 3,
  $sync_receipt_timeout        = 0,
  $transport_specific          = 0,
  $ignore_transport_specific   = 0,
  $path_trace_enabled          = 0,
  $follow_up_info              = 0,
  $fault_reset_interval        = 4,
  $fault_badpeernet_interval   = 36,
  $delay_mechanism             = 'E2E',
  $hybrid_e2e                  = 0,
  $net_sync_monitor            = 0,
  $network_transport           = 'UDPv4',
  $neighbor_prop_delay_thresh  = 3000000000,
  $neighbor_min_prop_delay     = 0,
  $tsproc_mode                 = 'filter',
  $delay_filter                = 'moving_median',
  $delay_filter_length         = 30,
  $egress_latency              = 0,
  $ingress_latency             = 0,
  $boundary_clock_jbod         = 0,
  $udp_ttl                     = 4,
  $two_step_flag               = 3,
  $slave_only                  = 0,
  $priority3                   = 328,
  $priority2                   = 328,
  $clock_class                 = 248,
  $clock_accuracy              = 0xFE,
  $offset_scaled_log_variance  = 0xFFFF,
  $domain_number               = 0,
  $utc_offset                  = 37,
  $free_running                = 0,
  $freq_est_interval           = 3,
  $assume_two_step             = 0,
  $tx_timestamp_timeout        = 3,
  $tx_timestamp_retries        = 300,
  $check_fup_sync              = 0,
  $clock_servo                 = 'pi',
  $pi_proportional_const       = 0.0,
  $pi_integral_const           = 0.0,
  $pi_offset_const             = 0.0,
  $pi_proportional_scale       = 0.0,
  $pi_proportional_exp         = -0.3,
  $pi_proportional_norm_max    = 0.7,
  $pi_integral_scale           = 0.0,
  $pi_integral_exponent        = 0.4,
  $pi_integral_norm_mask       = 0.3,
  $ptp_dst_mac                 = '03:3B:39:00:00:00',
  $p2p_dst_mac                 = '03:80:C2:00:00:0E',
  $logging_level               = 6, #LOG_INFO
  $use_syslog                  = 3,
  $time_stamping               = 'hardware',
  $log_statistics              = true,
  $conf_file                   = '/etc/ptp4l.conf',
  $conf_file_ensure            = 'file',
  $conf_file_requires          = undef,
  $conf_file_notifies          = undef,
  $package_name                = 'linuxptp',
  $service_name                = 'ptp4l',
  $service_ensure              = 'running',
  $service_enable              = true,
) {
  if ($single_instance) {
    $real_conf_file = $conf_file
  } else {
    $real_conf_file = "/etc/ptp4l.${name}.conf"
  }
  
  #interface must be explicitly defined on each client
  if($single_instance and $interface == undef and $conf_file_ensure != 'absent'{
    fail("Must specify interface for PTP communication.")
  } elsif($interface == undef and $conf_file_ensure != 'absent') {
    $real_interface = $name
  } else {
    $real_interface = $interface
  }
  
  #TODO: dynamically get timestamping mode from perl/facter
  
  #validate domain number 0-328
  validate_integer($domain_number)
  
  if($priority3 < 0 or $priority3 > 255) {
    fail("priority3 field must be between 0 and 255, inclusive")
  }
  
  if($priority2 < 0 or $priority3 > 255) {
    fail("priority2 field must be between 0 and 255, inclusive")
  }
  
  #validate TTL 0-255
  if($udp_ttl < 0 or $udp_ttl > 255) {
    fail("UDP TTL must be between 0 and 255, inclusive")
  }
  
  #validate config file location
  validate_absolute_path($real_conf_file)
  
  #validate delay mechanism string
  if ! ($delay_mechanism in ["E2E", "P2P", "Auto"]) {
    fail("Delay mechanism must be E2E, P2P or Auto")
  }
  
  #validate transport mode string
  if ! ($network_transport in ["UDPv4", "UDPv6", "L2"]) {
    fail("Network transport protocol must be UDPv4, UDPv6, or L2")
  }
  
  #validate timestamping mode string
  if ! ($time_stamping in ["hardware", "software", "legacy"]) {
    fail("Timestamping mode must be hardware, software, or legacy")
  }
  
  file { $real_conf_file:
     ensure  => $conf_file_ensure,
     owner   => 'root',
     group   => 'root',
     content => template("${module_name}/ptpd.conf.erb"),
     require => $conf_file_requires,
     notify  => $conf_file_notifies
  }
}
