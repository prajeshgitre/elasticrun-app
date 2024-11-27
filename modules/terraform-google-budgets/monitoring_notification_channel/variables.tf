
#notification channel details
variable "notification_display_name" {
  description = "display name for notification"
  type        = string
}

variable "notification_type" {
  description = "type of notification email/slack"
  type        = string
}

variable "email_address" {
  description = "list of email"
  type        = string
}

variable "notification_project" {
  description = "notification project id"
  type        = string
}