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
    project_roles = ["prj-prod-svc-elasticrun-01-94=>roles/GuestPolicy Viewer",
                     "prj-prod-svc-elasticrun-01-94=>roles/OS Inventory Viewer",
                     "prj-prod-svc-elasticrun-01-94=>roles/Service Account User",
                     "prj-prod-svc-elasticrun-01-94=>roles/Storage Admin"]
  },
  {
    project_id    = "prj-prod-svc-elasticrun-01-94"
    prefix        = ""
    display_name  = "sa-er-prod-as2-gke-eng-node-01"
    names         = ["sa-er-prod-as2-gke-eng-node-01"]
    project_roles = ["prj-prod-svc-elasticrun-01-94=>roles/Artifact Registry Administrator",
                     "prj-prod-svc-elasticrun-01-94=>roles/Service Account User"]
  },

  {
    project_id    = "prj-prod-svc-elasticrun-01-94"
    prefix        = ""
    display_name  = "sa-er-prod-as2-gke-eng-node-02"
    names         = ["sa-er-prod-as2-gke-eng-node-02"]
    project_roles = ["prj-prod-svc-elasticrun-01-94=>roles/Artifact Registry Administrator",
                     "prj-prod-svc-elasticrun-01-94=>roles/Service Account User"]
  },

  {
    project_id    = "prj-prod-svc-elasticrun-01-94"
    prefix        = ""
    display_name  = "sa-er-prod-as2-gke-eng-node-03"
    names         = ["sa-er-prod-as2-gke-eng-node-03"]
    project_roles = ["prj-prod-svc-elasticrun-01-94=>roles/Service Account User"]
  },

  {
    project_id    = "prj-prod-svc-elasticrun-01-94"
    prefix        = ""
    display_name  = "sa-er-prod-as2-gke-eng-cluster"
    names         = ["sa-er-prod-as2-gke-eng-cluster"]
    project_roles = ["prj-prod-svc-elasticrun-01-94=>roles/Service Account User"]
  },

  {
    project_id    = "prj-prod-svc-elasticrun-01-94"
    prefix        = ""
    display_name  = "sa-er-prod-as2-gke-app-cluster"
    names         = ["sa-er-prod-as2-gke-app-cluster"]
    project_roles = ["prj-prod-svc-elasticrun-01-94=>roles/Service Account User",
                     "prj-prod-svc-elasticrun-01-94=>roles/Artifact Registry Reader",
                    "prj-prod-svc-elasticrun-01-94=>roles/Artifact Registry Writer"
                    ]
  },

  {
    project_id    = "prj-prod-svc-elasticrun-01-94"
    prefix        = ""
    display_name  = "sa-er-prod-as2-gke-app-node-01"
    names         = ["sa-er-prod-as2-gke-app-node-01"]
    project_roles = ["prj-prod-svc-elasticrun-01-94=>roles/Artifact Registry Administrator",
                     "prj-prod-svc-elasticrun-01-94=>roles/Service Account User"]
  },

  {
    project_id    = "prj-prod-svc-elasticrun-01-94"
    prefix        = ""
    display_name  = "sa-er-prod-as2-gke-app-node-02"
    names         = ["sa-er-prod-as2-gke-app-node-02"]
    project_roles = ["prj-prod-svc-elasticrun-01-94=>roles/Artifact Registry Administrator",
                     "prj-prod-svc-elasticrun-01-94=>roles/Service Account User"]
  },

  {
    project_id    = "prj-prod-svc-elasticrun-01-94"
    prefix        = ""
    display_name  = "sa-er-prod-as2-gke-app-node-03"
    names         = ["sa-er-prod-as2-gke-app-node-03"]
    project_roles = ["prj-prod-svc-elasticrun-01-94=>roles/Artifact Registry Administrator",
                     "prj-prod-svc-elasticrun-01-94=>roles/Service Account User"]
  },

  {
    project_id    = "prj-prod-svc-elasticrun-01-94"
    prefix        = ""
    display_name  = "sa-er-prod-as2-gke-app-node-04"
    names         = ["sa-er-prod-as2-gke-app-node-04"]
    project_roles = ["prj-prod-svc-elasticrun-01-94=>roles/Service Account User"]
  },
  {
    project_id    = "prj-prod-svc-elasticrun-01-94"
    prefix        = ""
    display_name  = "sa-er-prod-as2-workload-01"
    names         = ["sa-er-prod-as2-workload-01"]
    project_roles = ["prj-prod-svc-elasticrun-01-94=>roles/Artifact Registry Administrator",
                     "prj-prod-svc-elasticrun-01-94=>roles/Service Account User",
                     "prj-prod-svc-elasticrun-01-94=>roles/Artifact Registry Create-on-Push Repository Administrator",
                     "prj-prod-svc-elasticrun-01-94=>roles/Artifact Registry Reader",
                     "prj-prod-svc-elasticrun-01-94=>roles/Compute Admin",
                     "prj-prod-svc-elasticrun-01-94=>roles/Pub/Sub Publisher",
                     "prj-prod-svc-elasticrun-01-94=>roles/Service Account Token Creator",
                     "prj-prod-svc-elasticrun-01-94=>roles/Storage Admin",
                     "prj-prod-svc-elasticrun-01-94=>roles/Storage Transfer Admin",
                     "prj-prod-svc-elasticrun-01-94=>roles/Storage Transfer Agent",
                     "prj-prod-svc-elasticrun-01-94=>roles/Workload Identity User"

                     ]
                     
  },
    {
    project_id    = "prj-prod-svc-elasticrun-01-94"
    prefix        = ""
    display_name  = "sa-er-prod-as2-workload-02"
    names         = ["sa-er-prod-as2-workload-02"]
    project_roles = ["prj-prod-svc-elasticrun-01-94=>roles/Service Account User"]
  },

]