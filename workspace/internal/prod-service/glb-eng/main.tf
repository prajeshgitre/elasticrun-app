
module "gcp-lb-https" {
  providers = {
    google      = google.project
    google-beta = google-beta.project-beta
  }
  for_each               = { for x in var.list-of-glb : x.name => x }
  source                 = "../../../../modules/terraform-google-lb-http"
  project                = each.value.project
  name                   = each.value.name
  create_address         = each.value.create_address
  static_address_name    = each.value.static_address_name
  create_ssl_policy      = each.value.create_ssl_policy
  ssl_policy_name        = each.value.ssl_policy_name
  ssl_policy_profile     = each.value.ssl_policy_profile
  ssl_policy_tls_version = each.value.ssl_policy_tls_version
  firewall_networks      = each.value.firewall_networks
  firewall_projects      = each.value.firewall_projects
  #   frontend_name         = each.value.frontend_name
  #locality_lb_policy    = each.value.locality_lb_policy
  load_balancing_scheme = each.value.load_balancing_scheme
  target_tags           = each.value.target_tags
  #create_url_map        = each.value.create_url_map
  #url_map = each.value.url_map
  managed_ssl_certificate_domains = each.value.managed_ssl_certificate_domains
  https_redirect                  = each.value.https_redirect
  # host_rule                       = each.value.host_rule
  # create_health_check_firewall = each.value.create_health_check_firewall
  backends         = each.value.backends
  certificate_map  = each.value.certificate_map
  ssl              = each.value.ssl
  ssl_certificates = each.value.ssl_certificates
  #backend_buckets = each.value.backend_buckets
}

