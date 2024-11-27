
// Create the BigQuery dataset for billing export
resource "google_bigquery_dataset" "dataset" {
  dataset_id  = var.dataset_name
  description = var.description
  location    = var.region
  project     = var.project_id

  dynamic "default_encryption_configuration" {
    for_each = var.default_encryption_configuration == null ? [] : [var.default_encryption_configuration]
    content {
      kms_key_name = var.default_encryption_configuration.kms_key_name
    }
  }
}

