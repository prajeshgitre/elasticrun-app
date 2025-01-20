project = {
  name            = "prj-seed-elasticrun",
  service_account = "sa-terraform-app@prj-seed-elasticrun.iam.gserviceaccount.com"
}

list-of-glb = [{
  project             = "prj-prod-svc-elasticrun-01-94"
  name                = "glb-prod-svc-as2-app"
  create_address      = true
  static_address_name = "sip-ext-prod-as2-app-glb"
  firewall_networks   = ["vpc-stage-shrd-host-01"]
  firewall_projects   = ["prj-stage-shrd-host-o4s-01-20"]
  frontend_name       = "fe-prod-elasticrun-as2-lb"
  # locality_lb_policy    = "LEAST_REQUEST"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  target_tags           = []
  host_rule = [
    # {
    #     path_matcher = "default"
    #     hosts        = ["dr-cas.elasticrun.in"]
    #     backend      = "app-01"

    # },
    {
      path_matcher = "api"
      hosts        = ["dr-spine.elasticrun.in"]
      backend      = "eng-01"
    },
  ]

  #custom SSL policy
  create_ssl_policy      = false
  ssl_policy_name        = "ssl-policy-prod-orf-tls-1-2-modern"
  ssl_policy_profile     = "MODERN"
  ssl_policy_tls_version = "TLS_1_2"

  #create_url_map = true
  # create_health_check_firewall = false
  certificate_map  = null
  ssl              = true
  ssl_certificates = ["elasticrun-in-certificate"]
  # use_ssl_certificates            = true
  managed_ssl_certificate_domains = []
  https_redirect                  = true
  backends = {
    app-01 = {
      backend_name                    = "be-prod-elasticrun-as2-lb-app"
      description                     = null
      port                            = "80"
      protocol                        = "HTTP"
      port_name                       = "http"
      timeout_sec                     = 180
      enable_cdn                      = false
      custom_response_headers         = null
      security_policy                 = "ca-prod-as2-security-policy"
      compression_mode                = null
      connection_draining_timeout_sec = null
      session_affinity                = null
      affinity_cookie_ttl_sec         = null
      custom_request_headers          = null
      health_check = {
        check_interval_sec  = null
        timeout_sec         = null
        healthy_threshold   = null
        unhealthy_threshold = null
        protocol            = "HTTP"
        request_path        = "/healthz"
        port                = "80"
        host                = null
        logging             = null
      }

      log_config = {
        enable      = true
        sample_rate = 0.1
      }

      groups = [
        {
          # Each node pool instance group should be added to the backend.
          group                        = "projects/prj-prod-svc-elasticrun-01-94/zones/asia-south2-a/networkEndpointGroups/ingress-nginx-80-neg-http"
          balancing_mode               = "RATE"
          capacity_scaler              = null
          description                  = null
          max_connections              = null
          max_connections_per_instance = null
          max_connections_per_endpoint = null
          max_rate                     = null
          max_rate_per_instance        = null
          max_rate_per_endpoint        = "100000"
          max_utilization              = null
        },

      ]

      iap_config = {
        enable               = false
        oauth2_client_id     = null
        oauth2_client_secret = null
      }
    },
    eng-01 = {
      backend_name                    = "be-prod-elasticrun-as2-lb-eng"
      description                     = null
      port                            = "80"
      protocol                        = "HTTP"
      port_name                       = "http"
      timeout_sec                     = 180
      enable_cdn                      = false
      custom_response_headers         = null
      security_policy                 = "ca-prod-as2-security-policy"
      compression_mode                = null
      connection_draining_timeout_sec = null
      session_affinity                = null
      affinity_cookie_ttl_sec         = null
      custom_request_headers          = null
      health_check = {
        check_interval_sec  = null
        timeout_sec         = null
        healthy_threshold   = "5"
        unhealthy_threshold = "5"
        protocol            = "HTTP"
        request_path        = "/healthz"
        port                = "10254"
        host                = null
        logging             = null
      }

      log_config = {
        enable      = true
        sample_rate = 0.1
      }

      groups = [
        {
          # Each node pool instance group should be added to the backend.
          group                        = "projects/prj-prod-svc-elasticrun-01-94/zones/asia-south2-a/networkEndpointGroups/ingress-nginx-engg-80-neg-http"
          balancing_mode               = "RATE"
          capacity_scaler              = null
          description                  = null
          max_connections              = null
          max_connections_per_instance = null
          max_connections_per_endpoint = null
          max_rate                     = null
          max_rate_per_instance        = null
          max_rate_per_endpoint        = "100000"
          max_utilization              = null
        },

      ]

      iap_config = {
        enable               = false
        oauth2_client_id     = null
        oauth2_client_secret = null
      }
    },
  }
  }
]