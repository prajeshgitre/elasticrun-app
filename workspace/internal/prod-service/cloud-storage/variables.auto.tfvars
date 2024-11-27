project = {
  name            = "prj-seed-elasticrun",
  service_account = "sa-terraform@prj-seed-elasticrun.iam.gserviceaccount.com"
}

//Cloud Storage
cloud_storage = [
  {
    project_id = ""
    name       = "bkt-"
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
