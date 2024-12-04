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

    {
    project_id    = "prj-prod-svc-elasticrun-01-94"
    prefix        = ""
    display_name  = "sa-er-prod-as2-gke-eng-node-01"
    names         = ["sa-er-prod-as2-gke-eng-node-01"]
    project_roles = []
  },

    {
    project_id    = "prj-prod-svc-elasticrun-01-94"
    prefix        = ""
    display_name  = "sa-er-prod-as2-gke-eng-node-02"
    names         = ["sa-er-prod-as2-gke-eng-node-02"]
    project_roles = []
  },

    {
    project_id    = "prj-prod-svc-elasticrun-01-94"
    prefix        = ""
    display_name  = "sa-er-prod-as2-gke-eng-node-03"
    names         = ["sa-er-prod-as2-gke-eng-node-03"]
    project_roles = []
  },

    {
    project_id    = "prj-prod-svc-elasticrun-01-94"
    prefix        = ""
    display_name  = "sa-er-prod-as2-gke-eng-cluster"
    names         = ["sa-er-prod-as2-gke-eng-cluster"]
    project_roles = []
  },

    {
    project_id    = "prj-prod-svc-elasticrun-01-94"
    prefix        = ""
    display_name  = "sa-er-prod-as2-gke-app-cluster"
    names         = ["sa-er-prod-as2-gke-app-cluster"]
    project_roles = []
  },

    {
    project_id    = "prj-prod-svc-elasticrun-01-94"
    prefix        = ""
    display_name  = "sa-er-prod-as2-gke-app-node-01"
    names         = ["sa-er-prod-as2-gke-app-node-01"]
    project_roles = []
  },

    {
    project_id    = "prj-prod-svc-elasticrun-01-94"
    prefix        = ""
    display_name  = "sa-er-prod-as2-gke-app-node-02"
    names         = ["sa-er-prod-as2-gke-app-node-02"]
    project_roles = []
  },

    {
    project_id    = "prj-prod-svc-elasticrun-01-94"
    prefix        = ""
    display_name  = "sa-er-prod-as2-gke-app-node-03"
    names         = ["sa-er-prod-as2-gke-app-node-03"]
    project_roles = []
  },

    {
    project_id    = "prj-prod-svc-elasticrun-01-94"
    prefix        = ""
    display_name  = "sa-er-prod-as2-gke-app-node-04"
    names         = ["sa-er-prod-as2-gke-app-node-04"]
    project_roles = []
  },
      {
    project_id    = "prj-prod-svc-elasticrun-01-94"
    prefix        = ""
    display_name  = "sa-er-prod-as2-workload-01"
    names         = ["sa-er-prod-as2-workload-01"]
    project_roles = []
  },
]