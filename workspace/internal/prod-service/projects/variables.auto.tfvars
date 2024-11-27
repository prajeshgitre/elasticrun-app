project = {
  name            = "prj-seed-elasticrun",
  service_account = "sa-terraform@prj-seed-elasticrun.iam.gserviceaccount.com"
}


//billing account id
billing_account = "01C4D7-B0D936-B27FBF"


// Service Project Creation
service_projects_list = {
  srv_proj01 = {
    prefix         = "prj"
    project_name   = "prod-svc-elasticrun-01"
    project_id     = "prod-svc-elasticrun-01"
    project_folder = "folders/704536984001"
    labels = {
      environment = "production"
      owner       = "manoj"
      department  = "elasticrun"
      customer    = "manoj"
      businessunit = "internal"
  
    }
    activate_apis = ["compute.googleapis.com"]
  },
  
}

#budget alert details
amount                  = 50000
notification_type       = "email"
notification_email      = "manoj.thangaraj@elastic.run" #
notification_project_id = "prj-cmn-int-elasticrun5a"
thresholds = [
  {
    percentage = 0.5,
    basis      = "CURRENT_SPEND"
  },
  {
    percentage = 0.75,
    basis      = "CURRENT_SPEND"
  },
  {
    percentage = 0.9
    basis      = "CURRENT_SPEND"
  },

]
