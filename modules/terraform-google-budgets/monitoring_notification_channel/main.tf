resource "google_monitoring_notification_channel" "notification_channel" {
  display_name = var.notification_display_name
  type         = var.notification_type
  project      = var.notification_project
  labels = {
    email_address = var.email_address
  }
}
output "id" {
  value = google_monitoring_notification_channel.notification_channel.name
}