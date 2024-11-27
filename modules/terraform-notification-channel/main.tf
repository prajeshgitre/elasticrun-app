resource "google_monitoring_notification_channel" "email" {
  for_each     = toset(var.email)
  project      = var.project
  display_name = each.key
  type         = "email"
  labels = {
    email_address = each.key
  }
  force_delete = false
  user_labels  = var.labels

}

resource "google_monitoring_notification_channel" "pagerduty" {
  for_each     = toset(var.pagerduty)
  display_name = "pagerduty"
  type         = "pagerduty"
  labels = {
    service_key = each.key
  }
  force_delete = false
  user_labels  = var.labels

}

resource "google_monitoring_notification_channel" "webhook" {
  for_each     = toset(var.webhook)
  display_name = "webhook"
  type         = "webhook_tokenauth"
  labels = {
    url = each.key
  }
  force_delete = false
  user_labels  = var.labels

}


output "notification_channel_id" {
  value = merge(
    { for i, k in google_monitoring_notification_channel.email : k.labels["email_address"] => k.id },
    { for i, k in google_monitoring_notification_channel.pagerduty : k["display_name"] => k.id },
    { for i, k in google_monitoring_notification_channel.webhook : k["display_name"] => k.id }
  )
}
