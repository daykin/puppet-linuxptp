class ptp4l(
  $single_instance             = true,
  $interface                   = undef,
  $delay_asymmetry             = 0,
  $log_announce_interval       = 1,
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
  $fault_badpeernet_interval   = 16,
  $delay_mechanism             = 'E2E',
  $hybrid_e2e                  = 0,
  $net_sync_monitor            = 0,
  $network_transport           = 'UDPv4',
  $neighbor_prop_delay_thresh  = 1000000000,
  $neighbor_min_prop_delay     = 0,
  $tsproc_mode                 = 'filter',
  $delay_filter                = 'moving_median',
  $delay_filter_length         = 10,
  $egress_latency              = 0,
  $ingress_latency             = 0,
  $boundary_clock_jbod         = 0,
  $udp_ttl                     = 4,
  $two_step_flag               = 1,
  $slave_only                  = 0,
  $priority1                   = 128,
  $priority2                   = 128,
  $clock_class                 = 248,
  $clock_accuracy              = 0xFE,
  $offset_scaled_log_variance  = 0xFFFF,
  $domain_number               = 0,
  $utc_offset                  = 37,
  $free_running                = 0,
  $freq_est_interval           = 1,
  $assume_two_step             = 0,
  $tx_timestamp_timeout        = 1,
  $tx_timestamp_retries        = 100,
  $check_fup_sync              = 0,
  $clock_servo                 = 'pi',
  $pi_proportional_const       = 0.0,
  $pi_integral_const           = 0.0,
  $pi_proportional_scale       = 0.0,
  $pi_proportional_exp         = -0.3,
  $pi_proportional_norm_max    = 0.7,
  $pi_integral_scale           = 0.0,
  $pi_integral_exponent        = 0.4,
  $pi_integral_norm_mask       = 0.3,
  $step_threshold              = 0.0,
  $first_step_threshold        = 0.00002,
  $max_frequency               = 900000000,
  $sanity_freq_limit           = 200000000,
  $initial_delay               = 0,
  $ntpshm_segment              = 0,
  $udp6_scope                  = 0x0E,
  $uds_address                 = 'var/run/ptp4l',
  $dscp_event                  = 0,
  $dscp_general                = 0,
  $message_tag                 = 'PTP',
  $verbose                     = 0,
  $summary_interval            = 0,
  $product_description         = ";;",
  $revision_data               = ";;",
  $user_description            = ".",
  $manufacturer_identity       = "00:00:00",
  $kernel_leap                 = "1",
  $ptp_dst_mac                 = '01:1B:19:00:00:00',
  $p2p_dst_mac                 = '01:80:C2:00:00:0E',
  $logging_level               = 6, #LOG_INFO
  $use_syslog                  = 1,
  $time_stamping               = 'hardware',
  $log_statistics              = true,
  $conf_file                   = '/etc/ptp4l.conf',
  $conf_file_ensure            = 'file',
  $conf_file_requires          = undef,
  $conf_file_notifies          = undef,
) {
  
  validate_string($package_name)

  package { $package_name:
    ensure => $package_ensure,
  }
  
  if ($single_instance) {
    if ($conf_file_ensure == 'absent') {
      $file_requires = Service[$service_name]
      $file_notifies = undef
    } else {
      $file_requires = Package[$package_name]
      $file_notifies = Service[$service_name]
    }
  
    ptp4l::instance { 'ptp4l':
      single_instance             => $single_instance,
      interface                   => $interface,
      delay_asymmetry             => $delay_asymmetry,
      log_announce_interval       => $log_announce_interval,
      log_sync_interval           => $log_sync_interval,
      log_min_delay_req_interval  => $log_min_delay_req_interval,
      log_min_pdelay_req_interval => $log_min_pdelay_req_interval,
      announce_receipt_timeout    => $announce_receipt_timeout,
      sync_receipt_timeout        => $sync_receipt_timeout,
      transport_specific          => $transport_specific,
      ignore_transport_specific   => $ignore_transport_specific,
      path_trace_enabled          => $path_trace_enabled,
      follow_up_info              => $follow_up_info,
      fault_reset_interval        => $fault_reset_interval,
      fault_badpeernet_interval   => $fault_badpeernet_interval,
      delay_mechanism             => $delay_mechanism,
      hybrid_e2e                  => $hybrid_e2e,
      net_sync_monitor            => $net_sync_monitor,
      network_transport           => $network_transport,
      neighbor_prop_delay_thresh  => $neighbor_prop_delay_thresh,
      neighbor_min_prop_delay     => $neighbor_min_prop_delay,
      tsproc_mode                 => $tsproc_mode,
      delay_filter                => $delay_filter,
      delay_filter_length         => $delay_filter_length,
      egress_latency              => $egress_latency,
      ingress_latency             => $ingress_latency,
      boundary_clock_jbod         => $boundary_clock_jbod,
      udp_ttl                     => $udp_ttl,
      two_step_flag               => $two_step_flag,
      slave_only                  => $slave_only,
      priority1                   => $priority1,
      priority2                   => $priority2,
      clock_class                 => $clock_class,
      clock_accuracy              => $clock_accuracy,
      offset_scaled_log_variance  => $offset_scaled_log_variance,
      domain_number               => $domain_number,
      utc_offset                  => $utc_offset,
      free_running                => $free_running,
      freq_est_interval           => $freq_est_interval,
      assume_two_step             => $assume_two_step,
      tx_timestamp_timeout        => $tx_timestamp_timeout,
      tx_timestamp_retries        => $tx_timestamp_retries,
      check_fup_sync              => $check_fup_sync,
      clock_servo                 => $clock_servo,
      pi_proportional_const       => $pi_proportional_const,
      pi_integral_const           => $pi_integral_const,
      pi_proportional_scale       => $pi_proportional_scale,
      pi_proportional_exp         => $pi_proportional_exp,
      pi_proportional_norm_max    => $pi_proportional_norm_max,
      pi_integral_scale           => $pi_integral_scale,
      pi_integral_exponent        => $pi_integral_exponent,
      pi_integral_norm_mask       => $pi_integral_norm_mask,
      step_threshold              => $step_threshold,
      first_step_threshold        => $first_step_threshold,
      max_frequency               => $max_frequency,
      sanity_freq_limit           => $sanity_freq_limit,
      initial_delay               => $initial_delay,
      ntpshm_segment              => $ntpshm_segment,
      udp6_scope                  => $udp6_scope,
      uds_address                 => $uds_address,
      dscp_event                  => $dscp_event,
      dscp_general                => $dscp_general,
      message_tag                 => $message_tag,
      verbose                     => $verbose,
      summary_interval            => $summary_interval,
      product_description         => $product_description,
      revision_data               => $revision_data,
      user_description            => $user_description,
      manufacturer_identity       => $manufacturer_identity,
      kernel_leap                 => $kernel_leap,
      ptp_dst_mac                 => $ptp_dst_mac,
      p2p_dst_mac                 => $p2p_dst_mac,
      logging_level               => $logging_level,
      use_syslog                  => $use_syslog,
      time_stamping               => $time_stamping,
      log_statistics              => $log_statistics,
      conf_file                   => $conf_file,
      conf_file_ensure            => $conf_file_ensure,
      conf_file_requires          => $file_requires,
      conf_file_notifies          => $file_notifies,
      package_name                => $package_name,
      service_name                => $service_name,
      service_ensure              => $service_ensure,
      service_enable              => $service_enable,
    }

    file { $conf_file :
      ensure  => $conf_file_ensure,
      owner   => 'root',
      group   => 'root',
      content => template("${module_name}/ptp4l_conf.erb"),
      require => $file_requires,
      notify  => $file_notifies,
    }
    
    service { $service_name:
      ensure     => $service_ensure,
      enable     => $service_enable,
      hasstatus  => true,
      hasrestart => true,
    }
  } else {
    file {$conf_file:
      ensure => absent,
    }
  }
}