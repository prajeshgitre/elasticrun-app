#cloud Armor
resource "google_compute_security_policy" "policy" {
  provider    = google-beta
  name        = var.policy_name
  project     = var.project
  type        = var.type
  description = var.armor_description
  adaptive_protection_config {
    layer_7_ddos_defense_config {
      enable = true
    }
  }

  dynamic "rule" {
    for_each = var.security_policies
    iterator = config
    content {
      action   = config.value.action
      priority = config.value.priority
      preview  = config.value.preview
      match {
        versioned_expr = config.value.expression
        config {
          src_ip_ranges = config.value.src_ip_ranges
        }
      }
      description = config.value.description
    }
  }


  dynamic "rule" {
    for_each = var.waf_rules
    iterator = config
    content {
      action   = config.value.action
      priority = config.value.priority
      preview  = config.value.preview
      match {
        expr {
          expression = config.value.expression
        }
      }
      description = config.value.description
    }
  }
}