data "google_compute_subnetwork" "nic_subnetwork" {
  for_each = { for key, x in var.network_interface : key => x }
  name     = each.value.nic_subnetwork
  project  = each.value.nic_subnetwork_project
  region   = each.value.nic_subnetwork_region
}
data "google_service_account" "vm-instance-account" {
  account_id = var.svc_account_id
  project    = var.project_id
}

locals {
  nics = flatten([
    for key, nic in var.network_interface : [{
      "nic_network"            = data.google_compute_subnetwork.nic_subnetwork[key].network
      "nic_subnetwork"         = data.google_compute_subnetwork.nic_subnetwork[key].self_link
      "nic_subnetwork_project" = nic.nic_subnetwork_project
      "nic_alias_ip_ranges"    = nic.nic_alias_ip_ranges
      "nic_access_config"      = nic.nic_access_config
      "nic0_network_ip"        = nic.nic0_network_ip
      }
    ]
  ])
}

locals {
  all_disk = flatten([
    for key, additional_disk in var.additional_disks : [{
      disk_name           = "${var.instance_name}-${additional_disk.name}-${key}"
      device_name         = "${var.instance_name}-${additional_disk.name}-${key}"
      auto_delete         = additional_disk.auto_delete
      boot                = additional_disk.boot
      disk_size_gb        = additional_disk.disk_size_gb
      disk_type           = additional_disk.disk_type
      disk_labels         = additional_disk.disk_labels
      mode                = additional_disk.mode
      zone                = var.zone
      svc_project_id      = var.project_id
      disk_encryption_key = additional_disk.disk_encryption_key
    }]
  ])
}


resource "google_compute_disk" "attach_disk" {
  for_each = { for x in local.all_disk : x.disk_name => x }
  project  = each.value.svc_project_id
  zone     = var.zone
  name     = each.value.disk_name
  type     = each.value.disk_type
  size     = each.value.disk_size_gb
  # disk_encryption_key {
  #   kms_key_self_link = each.value.disk_encryption_key
  # }
}

resource "google_compute_disk" "boot_disk" {
  for_each = { for x in var.boot_disk : x.name => x }
  project  = var.project_id
  zone     = var.zone
  name     = "${var.instance_name}-${each.value.name}"
  type     = each.value.boot_disk_type
  image    = each.value.source_image
  size     = each.value.boot_size
  # disk_encryption_key {
  #   kms_key_self_link = each.value.disk_encryption_key
  # }
  # source        = var.source_image
  # source_image_family  = var.source_image_family
  # source_image_project = var.source_image_project
  # auto_delete          = var.auto_delete
  # boot_disk_type       = var.boot_disk_type
  # disk_labels          = {}
  # boot_size            = var.boot_size

}

resource "google_compute_instance" "vm_instance" {
  depends_on = [
    google_compute_disk.attach_disk,
    google_compute_disk.boot_disk
  ]
  project             = var.project_id
  name                = var.instance_name
  enable_display      = var.enable_display
  resource_policies   = []
  zone                = var.zone
  machine_type        = var.machine_type
  hostname            = var.hostname
  labels              = var.labels
  can_ip_forward      = var.can_ip_forward
  deletion_protection = var.deletion_protection
  metadata            = var.metadata

  dynamic "boot_disk" {
    for_each = var.boot_disk
    content {
      #kms_key_self_link = var.disk_encryption_key
      auto_delete = var.boot_auto_delete
      source      = google_compute_disk.boot_disk[var.active_boot_name].self_link
      device_name = "${var.instance_name}-${boot_disk.value["name"]}"
      # initialize_params {
      #   image = var.source_image
      #   size  = var.boot_size
      #   type  = var.boot_disk_type

      # }
    }
  }
  dynamic "attached_disk" {
    for_each = local.all_disk
    content {
      kms_key_self_link = var.disk_encryption_key
      device_name       = attached_disk.value["device_name"]
      mode              = attached_disk.value["mode"]
      source            = attached_disk.value["disk_name"]
    }
  }
  tags = var.tags
  /* shielded_instance_config { 
      enable_secure_boot = var.enable_secure_boot
      enable_integrity_monitoring   =   var.enable_integrity_monitoring
      enable_vtpm   =   var.enable_vtpm
       } */
  allow_stopping_for_update = true
  dynamic "network_interface" {
    for_each = local.nics
    content {
      network            = network_interface.value.nic_network
      subnetwork         = network_interface.value.nic_subnetwork
      subnetwork_project = network_interface.value.nic_subnetwork_project
      network_ip         = network_interface.value.nic0_network_ip #length(var.nic0_network_ip) > 0 ? var.nic0_network_ip : null
      dynamic "alias_ip_range" {
        for_each = network_interface.value.nic_alias_ip_ranges
        content {
          ip_cidr_range         = alias_ip_range.value.nic_ip_cidr_range
          subnetwork_range_name = alias_ip_range.value.nic_subnetwork_range_name

        }
      }
      dynamic "access_config" {
        for_each = network_interface.value.nic_access_config
        content {
          nat_ip       = access_config.value.nic_nat_ip
          network_tier = access_config.value.nic_network_tier
        }
      }
    }
  }
  service_account {
    email  = data.google_service_account.vm-instance-account.email
    scopes = var.svc_account_scope
  }
}
