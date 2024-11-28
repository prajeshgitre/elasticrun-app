variable "list_of_vms" {
  description = ""
  type = list(object({
    machine_type     = string
    tags             = list(string)
    labels           = map(string)
    boot_size        = number
    source_image     = string
    boot_disk_type   = string
    boot_auto_delete = bool
    zone             = string
    # kms_key_self_link   = string
    instance_name       = string
    project_id          = string
    deletion_protection = bool
    svc_account_id      = string
    static_ip_name      = string
    enable_secure_boot  = bool
    network_interface = list(object({
      nic_subnetwork         = string
      nic_subnetwork_project = string
      nic_subnetwork_region  = string
      nic_access_config = list(object({
        nic_nat_ip       = string
        nic_network_tier = string

      }))
    }))
    additional_disks = list(object({
      disk_name    = string
      device_name  = string
      auto_delete  = bool
      boot         = bool
      mode         = string
      disk_size_gb = number
      disk_type    = string
      disk_labels  = map(string)
    }))

  }))
  default = []
}