project = {
  name            = "prj-seed-elasticrun",
  service_account = "sa-terraform-app@prj-seed-elasticrun.iam.gserviceaccount.com"
}

reserve_static_ip = [
  {
    name         = "sip-int-elasticrun-prod-as2-mariadb"
    project_id   = "prj-prod-svc-elasticrun-01-94"
    region       = "asia-south2"
    address_type = "INTERNAL"
    subnetwork = "sb-prod-as2-db"
  },
]