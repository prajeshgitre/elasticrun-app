/**
 * Copyright 2019 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/******************************************
  Locals configuration and validation
 *****************************************/
locals {
  dns_args_missing         = var.enable_cloud_dns && var.dns_domain == "" && var.dns_project == "" && var.dns_managed_zone == "" ? 1 : 0
  ptr_args_missing         = var.enable_reverse_dns && var.dns_reverse_zone == "" ? 1 : 0
  dns_fqdns                = formatlist("%s.%s", var.dns_short_names, var.dns_domain)
  regional_addresses_count = var.global ? 0 : length(var.names)
  global_addresses_count   = var.global ? length(var.names) : 0
  dns_forward_record_count = var.enable_cloud_dns ? length(local.dns_fqdns) : 0
  dns_reverse_record_count = var.enable_reverse_dns ? length(local.dns_fqdns) : 0
  ip_addresses = concat(
    google_compute_address.ip[*],
    google_compute_global_address.global_ip,
  )
  prefix_length = var.address_type == "EXTERNAL" || (var.address_type == "INTERNAL" && var.purpose == "PRIVATE_SERVICE_CONNECT") ? null : var.prefix_length
}

data "google_compute_subnetwork" "network" {
  name    = var.subnetwork
  project = var.network_project == "" ? var.project_id : var.network_project
  region  = var.region
}


/******************************************
  IP address reservation
 *****************************************/
resource "google_compute_address" "ip" {
  #count        = local.regional_addresses_count
  for_each     = toset(var.names)
  project      = var.project_id
  region       = var.region
  name         = each.value
  subnetwork   = data.google_compute_subnetwork.network.self_link
  address_type = var.address_type
  purpose      = var.address_type == "INTERNAL" ? var.purpose : null
  network_tier = var.address_type == "INTERNAL" ? null : var.network_tier
}

resource "google_compute_global_address" "global_ip" {
  count        = local.global_addresses_count
  project      = var.project_id
  name         = var.names[count.index]
  address_type = var.address_type
  address      = element(var.addresses, count.index)
  network      = var.address_type == "EXTERNAL" ? null : var.subnetwork
  purpose      = var.global && var.address_type == "INTERNAL" ? "VPC_PEERING" : null
  #prefix_length = local.prefix_length
  ip_version = var.ip_version
}
