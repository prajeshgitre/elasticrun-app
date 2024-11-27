project = {
  name            = "",
  service_account = ""
}


//billing account id
billing_account = "01E649-8FAD73-A6893C"


# Details of host projects
projects_list = {

}


// Service Project Creation
service_projects_list = {
  srv_proj01 = {
    prefix         = "prj"
    project_name   = ""
    project_id     = ""
    project_folder = "folders/101785720755"
    labels = {
  
    }
    activate_apis = ["compute.googleapis.com"]
  },
  
}

#budget alert details
amount                  = 50000
notification_type       = "email"
notification_email      = "" #verify
notification_project_id = "common-service-f0"
thresholds = [{
  percentage = 0.25,
  basis      = "CURRENT_SPEND"
  },
  {
    percentage = 0.5,
    basis      = "CURRENT_SPEND"
  },
  {
    percentage = 0.75,
    basis      = "CURRENT_SPEND"
  },
  {
    percentage = 0.8,
    basis      = "CURRENT_SPEND"
  },
  {
    percentage = 0.9
    basis      = "CURRENT_SPEND"
  },
  {
    percentage = 0.25,
    basis      = "FORECASTED_SPEND"
  },
  {
    percentage = 0.5,
    basis      = "FORECASTED_SPEND"
  },
  {
    percentage = 0.75,
    basis      = "FORECASTED_SPEND"
  },
  {
    percentage = 0.8,
    basis      = "FORECASTED_SPEND"
  },
  {
    percentage = 0.9,
    basis      = "FORECASTED_SPEND"
  }
]
