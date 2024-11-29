project = {
  name            = "prj-infra-service",
  service_account = "sa-common-srv-terraform-deploy@prj-infra-services.iam.gserviceaccount.com"
}

//Artifact registory
artifact_registry = [
  {
    id          = "repo-o4s-stage-as1-kubernetes-artifacts"
    project_id  = "prj-stage-svc-o4s-01-45"
    location    = "asia-south1"
    description = ""
    format      = "DOCKER"
    labels = {
      "team" : "devops",
      "environment" : "stage",

    },
    iam = {
      "roles/artifactregistry.writer" = []
      "roles/artifactregistry.reader" = []
    }
  },
]