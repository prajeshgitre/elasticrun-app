//Backend GCS bucket to store state files
terraform {
  backend "gcs" {
    bucket = "bkt-elasticrun-bootstrap-asso2-terraform-state-app"
    prefix = "terraform/internal/prod-service/cloud_armor/state"
  }
}