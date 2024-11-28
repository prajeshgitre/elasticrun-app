project = {
  name            = "prj-seed-elasticrun",
  service_account = "sa-terraform-app@prj-seed-elasticrun.iam.gserviceaccount.com"
}



list_of_vms = [
  #anthro prod backend 
  {
    instance_name = "gce-elasticrun-prod-as2-mariadb-01",
    machine_type  = "n2d-highmem-2",
    project_id    = "prj-prod-svc-elasticrun-01-94",
    tags          = ["ssh","mariadb","db"],
    labels = {
      environment = "production"
      owner       = "manoj"
      department  = "elasticrun"
      customer    = "manoj"
      businessunit = "internal"
    },
    source_image        = "projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20241115",
    boot_size           = 500,
    boot_auto_delete    = false,
    static_ip_name      = "sip-int-elasticrun-prod-as2-mariadb"
    boot_disk_type      = "pd-ssd",
    zone                = "asia-south2-a",
    enable_secure_boot  = true
    deletion_protection = true,
    svc_account_id      = "sa-elasticrun-prod-as2-mariadb@prj-prod-svc-elasticrun-01-94.iam.gserviceaccount.com"
     additional_disks = [
     ]
    network_interface = [{
      nic_subnetwork         = "sb-prod-as2-db",
      nic_subnetwork_project = "prj-prod-int-elasticrun-hostc9",
      nic_subnetwork_region  = "asia-south2",
      nic0_network_ip        = "",
      nic_access_config      = []
    }]
  },
  
]