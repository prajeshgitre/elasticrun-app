// Variable for billing alert
variable "thresholds" {
  description = "thresholds for budget"
  type = list(object({
    percentage = number,
    basis      = string
  }))
  default = []
}

variable "amount" {
  description = "The amount to use as the budget"
  type        = number
}

variable "notification_project_id" {
  description = "common service project id of notification cannel"
  type        = string
}

variable "notification_type" {
  description = "type of notification email/slack"
  type        = string
}

variable "notification_email" {
  description = "list of email"
  type        = string
}

variable "billing_account" {
  description = "Billing account ID"
  type        = string
}

variable "projects_list" {
  description = "List of projects which needs to be created. project name, project id, folder under which project needs to be created"
  type = map(object({
    project_folder = string
    prefix         = string
    project_name   = string
    project_id     = string
    labels         = map(string)
  }))
}

variable "activate_apis" {
  description = "The list of apis to activate within the project"
  type        = list(string)
  default     = ["compute.googleapis.com"]
}

variable "service_projects_list" {
  description = "List of projects which needs to be created. project name, project id, folder under which project needs to be created"
  type = map(object({
    project_folder = string
    prefix         = string
    project_name   = string
    project_id     = string
    labels         = map(string)
  }))
}
