resource "google_monitoring_monitored_project" "project_instances" {
  provider      = google-beta
  for_each      = toset(var.project_names)
  metrics_scope = var.metrics_scope
  name          = "projects/${each.value}"
}
