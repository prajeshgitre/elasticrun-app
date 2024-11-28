project = {
  name            = "prj-seed-elasticrun",
  service_account = "sa-terraform-app@prj-seed-elasticrun.iam.gserviceaccount.com"
}

reserve_static_ip = [
  {
    name         = "sip-prod-static-data-collection-ip-01"
    project_id   = "wiai-mnch-anth-prod-srv-3c"
    region       = "asia-south1"
    address_type = "INTERNAL"
    subnetwork = "subnet-prod-anthro-asso1-01"
  },
    {
    name         = "sip-prod-static-fieldy-form-ip-02"
    project_id   = "wiai-mnch-anth-prod-srv-3c"
    region       = "asia-south1"
    address_type = "INTERNAL"
    subnetwork = "subnet-prod-anthro-asso1-01"
  },
]


  

