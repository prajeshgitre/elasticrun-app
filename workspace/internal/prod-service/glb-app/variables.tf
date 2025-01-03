variable "list-of-glb" {
  type = list(object({
    project                = string
    name                   = string
    create_address         = bool
    static_address_name    = string
    firewall_networks      = list(string)
    firewall_projects      = list(string)
    create_ssl_policy      = bool
    ssl_policy_name        = string
    ssl_policy_profile     = string
    ssl_policy_tls_version = string
    target_tags            = list(string)
    # frontend_name         = string
    #locality_lb_policy    = string
    load_balancing_scheme = string
    # firewall_networks = list(string)
    # firewall_projects = list(string)
    certificate_map = string
    #  create_health_check_firewall = bool
    ssl = bool
    # storage_bucket = string
    # # backend_buckets = list(object({
    #   name        = string
    #   bucket_name = string
    #   # Add more attributes as needed
    # }))
    ssl_certificates = list(string)
    # host_rule = list(object({
    #   path_matcher = string
    #   hosts        = list(string)
    #   backend      = string
    #   #service = string
    # }))
    managed_ssl_certificate_domains = list(string)
    https_redirect                  = bool
    backends = map(object({
      backend_name            = optional(string)
      port                    = optional(number)
      project                 = optional(string)
      protocol                = optional(string)
      port_name               = optional(string)
      description             = optional(string)
      enable_cdn              = optional(bool)
      compression_mode        = optional(string)
      security_policy         = optional(string, null)
      edge_security_policy    = optional(string, null)
      custom_request_headers  = optional(list(string))
      custom_response_headers = optional(list(string))

      timeout_sec                     = optional(number)
      connection_draining_timeout_sec = optional(number)
      session_affinity                = optional(string)
      affinity_cookie_ttl_sec         = optional(number)

      health_check = object({
        name                = optional(string)
        host                = optional(string)
        request_path        = optional(string)
        request             = optional(string)
        response            = optional(string)
        port                = optional(number)
        port_name           = optional(string)
        proxy_header        = optional(string)
        port_specification  = optional(string)
        protocol            = optional(string)
        check_interval_sec  = optional(number)
        timeout_sec         = optional(number)
        healthy_threshold   = optional(number)
        unhealthy_threshold = optional(number)
        logging             = optional(bool)
      })

      log_config = object({
        enable      = optional(bool)
        sample_rate = optional(number)
      })

      groups = list(object({
        group = string

        balancing_mode               = optional(string)
        capacity_scaler              = optional(number)
        description                  = optional(string)
        max_connections              = optional(number)
        max_connections_per_instance = optional(number)
        max_connections_per_endpoint = optional(number)
        max_rate                     = optional(number)
        max_rate_per_instance        = optional(number)
        max_rate_per_endpoint        = optional(number)
        max_utilization              = optional(number)
      }))
      iap_config = object({
        enable               = bool
        oauth2_client_id     = optional(string)
        oauth2_client_secret = optional(string)
      })
    }))
    # create_url_map = bool
    # url_map = string
  }))
}

