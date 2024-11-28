# Common-Service-Jenkins

This module makes it easy to create a new vm in GCP.

It supports creating:

- virtual machine in the specified folder under common service

## Usage
 The usage of the module could be like this in your own main.tf file:

```hcl
module "compute_instance" {
  providers = {
    google      = google.project
    google-beta = google-beta.project-beta
  }
  for_each                  = { for x in var.list_of_vms : x.instance_name => x }
  source                    = "../../../../modules/terraform-google-vm/compute_instance"
  project_id                = each.value.project_id
  zone                      = each.value.zone
  source_image              = each.value.source_image
  machine_type              = each.value.machine_type
  hostname                  = ""
  boot_disk_type            = each.value.boot_disk_type
  boot_size                 = each.value.boot_size == null ? 10 : each.value.boot_size
  boot_auto_delete          = each.value.boot_auto_delete
  deletion_protection       = each.value.deletion_protection
  tags                      = each.value.tags
  svc_account_id            = each.value.svc_account_id
  instance_name             = each.value.instance_name
  network_interface         = each.value.network_interface
  nic0_network_ip           = each.value.static_ip_name != null ? data.google_compute_address.ip[each.value.instance_name].address : ""
  labels                    = each.value.labels
  can_ip_forward            = false
  additional_disks          = each.value.additional_disks == null ? [] : each.value.additional_disks
  allow_stopping_for_update = true
  enable_secure_boot        = each.value.enable_secure_boot
  depends_on                = [data.google_compute_address.ip]

}

```
Then perform the following commands on the root folder:

- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Project APIs

The following APIs must be enabled on your project:
- `compute.googleapis.com`
- `iam.googleapis.com`

See also the [project_services](modules/project_services) module (optional).

## Creation of vm
```hcl
list_of_vms = [
  #Jenkins Server
  {
    instance_name = "vm-bootstrap-seed-asso1-jenkins-01",
    machine_type  = "n2d-standard-4",
    project_id    = "wiai-bootstrap-seed",
    tags          = ["ssh", "jenkins"],
    labels = {
        "owner_email": "pankaj-wadhwaniai-org"
        "department": "engineering"
        "sensitive_data": "yes"
        "environment": "prod"
        "workload": "iac"
        "state": "na"
    },
    source_image        = "projects/debian-cloud/global/images/debian-12-bookworm-v20240213",
    boot_size           = 30,
    boot_auto_delete    = false,
    static_ip_name      = "sip-bootstrap-seed-static-jenkins-ip-01"
    boot_disk_type      = "pd-standard",
    zone                = "asia-south1-a",
    enable_secure_boot  = true
    deletion_protection = true,
    svc_account_id      = "svcacct-bootstrap-seed-jenkins@wiai-bootstrap-seed.iam.gserviceaccount.com"
    additional_disks = [

      {
        disk_name           = "vm-bootstrap-seed-asso1-jenkins-disk-01"
        device_name         = "vm-bootstrap-seed-asso1-jenkins-01"
        name                = "vm-bootstrap-seed-asso1-jenkins-disk-01"
        disk_size_gb        = 100
        disk_encryption_key = ""
        disk_type           = "pd-standard"
        auto_delete         = "false"
        mode                = "READ_WRITE"
        boot                = "false"
        disk_labels         = { "app" : "jenkins" }
      }
    ]
    network_interface = [{
      nic_subnetwork         = "subnet-seed-asso1-01",
      nic_subnetwork_project = "wiai-bootstrap-seed",
      nic_subnetwork_region  = "asia-south1",
      nic0_network_ip        = null,
      nic_access_config      = []
    }]
  }
]

```