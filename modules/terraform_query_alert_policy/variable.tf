variable "type" {
  description = "Type of alert policy"
  type        = string
}

variable "project" {
  description = "Project ID where the alert policy will be created"
  type        = string
}

variable "display_name" {
  description = "A short name or phrase used to identify the alert policy"
  type        = string
}

variable "combiner" {
  description = "The operation used to combine conditions in the policy"
  type        = string
}

variable "notification_channels" {
  description = "List of notification channels to which notifications will be sent"
  type        = list(string)
}

variable "log_condition" {
  description = "List of log conditions for the alert policy"
  type        = list(object({
    display_name = string
    condition_matched_log = object({
      filter = string
    })
  }))
}

variable "content" {
  description = "Documentation content for the alert policy"
  type        = string
}

variable "alert_strategy" {
  description = "Alert strategy configuration"
  type        = object({
    auto_close = string
    notification_rate_limit = object({
      period = string
    })
  })
}

variable "labels" {
  description = "User-defined labels for the alert policy"
  type        = map(string)
}
