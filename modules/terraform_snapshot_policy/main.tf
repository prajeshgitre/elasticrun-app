resource "google_compute_disk_resource_policy_attachment" "attachment" {
  for_each = var.disk_zone_map
  project  = var.project
  name     = google_compute_resource_policy.policy.name
  disk     = each.key
  zone     = each.value
}


resource "google_compute_resource_policy" "policy" {
  name    = "gce-snapshot-policy"
  region  = "us-central1"
  project = var.project
  snapshot_schedule_policy {
    schedule {
      weekly_schedule {
        day_of_weeks {
          day        = "SATURDAY"
          start_time = "02:00"
        }
      }
    }
    retention_policy {
      max_retention_days    = 30
      on_source_disk_delete = "KEEP_AUTO_SNAPSHOTS"
    }
    snapshot_properties {
      labels = {
        label = "backup"
      }
      storage_locations = ["us-central1"]
      guest_flush       = true
    }
  }
}
