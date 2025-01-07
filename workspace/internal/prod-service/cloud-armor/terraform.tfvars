# *****************************************************
# cloud-armor
# *****************************************************
project = {
  name            = "prj-seed-elasticrun",
  service_account = "sa-terraform-app@prj-seed-elasticrun.iam.gserviceaccount.com",
} 
list_of_cloud_armor = [
  {
    project_id                           = "prj-prod-svc-elasticrun-01-94"
    name                                 = "ca-prod-as2-security-policy"
    description                          = "Security Policy"
    default_rule_action                  = "allow"
    type                                 = "CLOUD_ARMOR"
    layer_7_ddos_defense_enable          = true
    layer_7_ddos_defense_rule_visibility = "STANDARD"
    # Pre-configured WAF Rules
    security_rules = {
    #   "blacklist_ip_ranges" = {
    #   action        = "deny(502)"
    #   priority      = 5
    #   description   = "Blacklist IP address ranges"
    #   src_ip_ranges = [""]
    #   preview       = true
    #   rate_limit_options ={}
    # },
      "rate_based_ban" = {
        action        = "rate_based_ban"
        priority      = 1
        description   = "rate_based_ban"
        src_ip_ranges = ["*"]
        preview       = false
        rate_limit_options = {
          ban_duration_sec                     = 120
          enforce_on_key                       = "ALL"
          exceed_action                        = "deny(429)"
          rate_limit_http_request_count        = 1000
          rate_limit_http_request_interval_sec = 60
        }
      },
   }
    custom_rules = {
      block_specific_regions = {
        action      = "deny(502)"
        priority    = 2
        preview = true
        description = "Deny specific Regions"
        expression  = <<-EOT
          '[AU,BE]'.contains(origin.region_code)
        EOT
      }

      xss-stable = {
        action                  = "deny(502)"
        priority                = 10
        description             = "Cross-site scripting (XSS)"
        preview       = false
        expression  = <<-EOT
          evaluatePreconfiguredWaf('xss-v33-stable', {'sensitivity': 2})
        EOT
      },
      sql-injection = {
        action                  = "deny(502)"
        priority                = 20
        preview       = false
        description             = "SQL injection (SQLi)"
        expression  = <<-EOT
          evaluatePreconfiguredWaf('sqli-v33-stable', {'sensitivity': 2})
        EOT
      },
      local-file-inclusion = {
        action                  = "deny(502)"
        priority                = 30
        preview       = false
        description             = "Local file inclusion (LFI)"
        expression  = <<-EOT
          evaluatePreconfiguredWaf('lfi-v33-stable', {'sensitivity': 2})
        EOT
      },
      remote-code_execution = {
        action                  = "deny(502)"
        priority                = 40
        preview       = false
        description             = "Remote code execution (RCE)"
        expression  = <<-EOT
          evaluatePreconfiguredWaf('rce-v33-stable', {'sensitivity': 2})      
        EOT
      },
      remote-file-inclusion = {
        action                  = "deny(502)"
        priority                = 50
        preview       = false
        description             = "Remote file inclusion (RFI)"
        expression  = <<-EOT
          evaluatePreconfiguredWaf('rfi-v33-stable', {'sensitivity': 2})
          EOT
      },
      method-enforcement = {
        action                  = "deny(502)"
        priority                = 60
        preview       = false
        description             = "Method enforcement"
        expression  = <<-EOT
          evaluatePreconfiguredWaf('methodenforcement-v33-stable', {'sensitivity': 2})
        EOT
      },
      scanner-detection = {
        action                  = "deny(502)"
        priority                = 70
        preview       = false
        description             = "Scanner detection"
        expression  = <<-EOT
          evaluatePreconfiguredWaf('scannerdetection-v33-stable', {'sensitivity': 2})
        EOT
      },
      protocol-attack = {
        action                  = "deny(502)"
        priority                = 80
        preview       = false
        description             = "Protocol attack"
        expression  = <<-EOT
          evaluatePreconfiguredWaf('protocolattack-v33-stable', {'sensitivity': 2})
        EOT
      },
      php = {
        action                  = "deny(502)"
        priority                = 90
        preview       = false
        description             = "php"
        expression  = <<-EOT
          evaluatePreconfiguredWaf('php-v33-stable', {'sensitivity': 2})
        EOT
      },
      session-fixation = {
        action                  = "deny(502)"
        priority                = 100
        preview       = false
        description             = "Session fixation"
        expression  = <<-EOT
          evaluatePreconfiguredWaf('sessionfixation-v33-stable', {'sensitivity': 2})
        EOT
      },
      java-attack = {
        action                  = "deny(502)"
        priority                = 110
        preview       = false
        description             = "Java attack"
        expression  = <<-EOT
          evaluatePreconfiguredWaf('java-v33-stable', {'sensitivity': 2})
        EOT
      },
      nodejs-attack = {
        action                  = "deny(502)"
        priority                = 120
        preview       = false
        description             = "NodeJS attack"
        expression  = <<-EOT
          evaluatePreconfiguredWaf('nodejs-v33-stable', {'sensitivity': 2})
        EOT
      },
      cves-and-other-vulnerabilities = {
        action                  = "deny(502)"
        priority                = 130
        preview       = false
        description             = "CVEs and other vulnerabilities"
        expression  = <<-EOT
          evaluatePreconfiguredWaf('cve-canary', {'sensitivity': 2})
        EOT
      },
      JSON-formatted-content-SQLi-vulnerability = {
        action                  = "deny(502)"
        priority                = 140
        preview       = false
        description             = "JSON-formatted content SQLi vulnerability"
        expression  = <<-EOT
          evaluatePreconfiguredWaf('json-sqli-canary', {'sensitivity': 2})
        EOT
      },
    }
  }
]
