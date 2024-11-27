resource "google_monitoring_alert_policy" "log_alert_policy" {
  count        = var.type == "log" ? 1 : 0
  project      = var.project
  display_name = var.display_name
  combiner     = var.combiner

  notification_channels = var.notification_channels
  dynamic "conditions" {
    for_each = var.log_condition
    content {
      display_name = conditions.value.display_name

      condition_matched_log {
        filter = conditions.value.condition_matched_log.filter
        label_extractors = {
            "principal_email" = "EXTRACT(protoPayload.authenticationInfo.principalEmail)"
        }

      }
    }
  }
  documentation {
    content = var.content
  }

  alert_strategy {
    auto_close = var.alert_strategy.auto_close
    notification_rate_limit {
      period = try(var.alert_strategy.notification_rate_limit.period, null)
    }
  }

  user_labels = var.labels

}