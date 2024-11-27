resource "google_project_service_identity" "service-identity" {
  provider = google-beta
  project  = var.project_id
  service  = var.service
}

resource "google_secret_manager_secret" "secret" {
  project   = var.project_id
  secret_id = var.secret_id

  replication {
    user_managed {
      replicas {
        location = var.location
        # customer_managed_encryption {
        #   kms_key_name = var.kms_key_name
        # }
      }
    }
  }
  depends_on = [google_project_service_identity.service-identity]
}