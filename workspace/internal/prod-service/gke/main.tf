# Module to create VM
data "google_compute_network" "my-network" {
  for_each = { for x in var.list_of_gke : x.cluster_name => x }
  name     = each.value.network
  project  = each.value.project_host
}

data "google_compute_subnetwork" "my-subnetwork" {
  for_each = { for x in var.list_of_gke : x.cluster_name => x }
  name     = each.value.subnetwork
  region   = each.value.region
  project  = each.value.project_host
}

#module for creating GKE
module "gke" {
  # providers = {
  #   google      = google.project
  #   google-beta = google-beta.project-beta
  # }
  for_each = { for x in var.list_of_gke : x.cluster_name => x }
  # source                          = "../../../../modules/terraform-google-gke"
  source                          = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  project_id                      = each.value.project_service
  name                            = each.value.cluster_name
  region                          = each.value.region
  zones                           = [each.value.zone]
  regional                        = each.value.regional
  disable_default_snat            = each.value.disable_default_snat
  network                         = each.value.network
  subnetwork                      = each.value.subnetwork
  network_project_id              = each.value.network_project_id
  ip_range_pods                   = each.value.ip_range_pods
  ip_range_services               = each.value.ip_range_services
  http_load_balancing             = each.value.http_load_balancing
  cluster_resource_labels         = each.value.cluster_resource_labels
  network_policy                  = each.value.network_policy
  filestore_csi_driver            = each.value.filestore_csi_driver
  monitoring_service              = each.value.monitoring_service
  logging_service                 = each.value.logging_service
  enable_private_endpoint         = each.value.enable_private_endpoint
  enable_private_nodes            = each.value.enable_private_nodes
  enable_vertical_pod_autoscaling = each.value.enable_vertical_pod_autoscaling
  remove_default_node_pool        = each.value.remove_default_node_pool
  enable_binary_authorization     = each.value.enable_binary_authorization
  master_ipv4_cidr_block          = each.value.master_ipv4_cidr_block
  master_authorized_networks      = each.value.master_authorized_networks
  create_service_account          = each.value.create_service_account
  node_pools                      = each.value.node_pools
  enable_shielded_nodes           = each.value.enable_shielded_nodes
  release_channel                 = each.value.release_channel
  # master_version                  = each.value.master_version
  maintenance_start_time       = each.value.maintenance_start_time
  maintenance_end_time         = each.value.maintenance_end_time
  maintenance_recurrence       = each.value.maintenance_recurrence
  master_global_access_enabled = each.value.master_global_access_enabled
  # enable_intranode_visibility          = each.value.enable_intranode_visibility
  database_encryption          = each.value.database_encryption
  authenticator_security_group = each.value.authenticator_security_group
  default_max_pods_per_node    = each.value.default_max_pods_per_node

  # monitoring_enable_managed_prometheus = each.value.monitoring_enable_managed_prometheus
  node_pools_tags = {
    all            = ["ssh"]
    default_values = [false, false]
  }
}
