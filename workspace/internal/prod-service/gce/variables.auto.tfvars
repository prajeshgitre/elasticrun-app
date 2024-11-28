project = {
  name            = "prj-seed-elasticrun",
  service_account = "sa-terraform-app@prj-seed-elasticrun.iam.gserviceaccount.com"
}



list_of_vms = [
  #anthro prod backend 
  {
    instance_name = "",
    machine_type  = "e2-medium",
    project_id    = "",
    tags          = ["ssh","anth-prod","anth-fiedly-data-collection-prod","nat"],
    labels = {
        "owner_email": "jay"
        "department": "engineering"
        "sensitive_data": "no"
        "environment": "prod"
        "workload": "fieldy-app"
        "state": "na"
    },
    source_image        = "projects/ubuntu-os-cloud/global/images/ubuntu-2204-jammy-v20240307",
    boot_size           = 1024,
    boot_auto_delete    = false,
    static_ip_name      = "sip-prod-static-data-collection-ip-01"
    boot_disk_type      = "pd-ssd",
    zone                = "asia-south1-a",
    enable_secure_boot  = true
    deletion_protection = true,
    svc_account_id      = "svcacct-anthro-prod-data-clt@wiai-mnch-anth-prod-srv-3c.iam.gserviceaccount.com"
     additional_disks = [
     ]
    network_interface = [{
      nic_subnetwork         = "subnet-prod-anthro-asso1-01",
      nic_subnetwork_project = "wiai-prod-host-vpc-68",
      nic_subnetwork_region  = "asia-south1",
      nic0_network_ip        = "",
      nic_access_config      = []
    }]
  },
  
]