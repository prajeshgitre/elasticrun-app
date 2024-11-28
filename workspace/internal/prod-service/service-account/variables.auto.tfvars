project = {
  name            = "prj-seed-elasticrun",
  service_account = "sa-terraform-app@prj-seed-elasticrun.iam.gserviceaccount.com"
}

service_accounts_list = [
  {
    project_id    = "prj-prod-svc-elasticrun-01-94"
    prefix        = ""
    display_name  = "sa-elasticrun-prod-as2-mariadb"
    names         = ["sa-elasticrun-prod-as2-mariadb"]
    project_roles = []
  },
]