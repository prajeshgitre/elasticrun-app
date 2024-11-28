terraform {
  backend "gcs" {
    bucket = "bkt-elasticrun-bootstrap-asso2-terraform-state-app"
    prefix = "terraform/internal/prod-service/gke/state"
  }
}
