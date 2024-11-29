project = {
  name            = "prj-seed-elasticrun",
  service_account = "sa-terraform-app@prj-seed-elasticrun.iam.gserviceaccount.com"
}

//Artifact registory
artifact_registry = [
  {
    id          = "repo-elasticrun-prod-as2-kubernetes-artifacts"
    project_id  = "prj-prod-svc-elasticrun-01-94"
    location    = "asia-south2"
    description = ""
    format      = "DOCKER"
    labels = {
      "team" : "devops",
      "environment" : "prod",

    },
    iam = {
      "roles/artifactregistry.writer" = []
      "roles/artifactregistry.reader" = []
    }
  },
]