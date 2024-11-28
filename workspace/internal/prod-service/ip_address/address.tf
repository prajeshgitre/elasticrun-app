module "address" {
  providers = {
    google      = google.project
    google-beta = google-beta.project-beta
  }

  source       = "../../../../../modules/terraform_google_address"
  for_each     = { for ip in var.reserve_static_ip : ip.name => ip }
  names        = [each.value.name]
  region       = each.value.region
  project_id   = each.value.project_id
  subnetwork   = each.value.subnetwork
  global       = false
  address_type = each.value.address_type
  network_project ="wiai-prod-host-vpc-68"
}
