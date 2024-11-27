project = {
  name            = "prj-seed-elasticrun",
  service_account = "sa-terraform-app@prj-seed-elasticrun.iam.gserviceaccount.com"
}

//Cloud Storage
cloud_storage = [
  {
    project_id = "prj-prod-svc-elasticrun-01-94"
    name       = "bkt-elasticrun-prod-mysql-01"
    location   = "asia-south2"
    versioning = true
    public_access_prevention = "inherited"
    labels = {
        "owner": "manoj"
         businessunit : "internal"
        "requestort": "manoj"
        "environment": "prod"
     
    }, 
  },
]
