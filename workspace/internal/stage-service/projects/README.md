#  Project

This module allows you to create Host projects. It
creates projects and configures aspects like Billing budget, notification channel.

## Usage

```hcl
module "create_project" {
  source          = "../../../modules/terraform-google-project-factory"
  for_each        = var.projects_list
  name            = each.value.project_name
  project_id      = format("%s%s", each.value.project_id, random_id.project_id_suffix.hex)
  folder_id       = each.value.project_folder
  labels          = each.value.labels
  billing_account = var.billing_account
  activate_apis   = var.activate_apis
}

module "budget_notification_channel" {
  for_each   = toset(local.project_ids)
  source     = "../../../modules/terraform-google-budget/monitoring_notification_channel"
  notification_display_name = "Notification channel for ${each.key}"
  notification_type = var.notification_type
  notification_project = each.key
  email_address = var.email_address
}

module "budget" {
  source          = "../../../modules/terraform-google-budget"
  for_each   = toset(local.project_ids)
  billing_account = var.billing_account
  projects        = [each.key]
  amount          = var.amount
  thresholds      = var.thresholds
  notification_name = [module.budget_notification_channel["${each.key}"].id, data.google_monitoring_notification_channel.notification_channel.id]
}
```

## Features

This module will take the following actions:

1. Create a new GCP host project.
1. Creation of  Billing budget.
1. Creation of  notification channel 

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| activate\_apis | The list of apis to activate within the project | `list(string)` | <pre>[<br>  "compute.googleapis.com"<br>]</pre> 
| billing\_account | The ID of the billing account to associate this project with | `string` | n/a |
| folder\_id | The ID of a folder to host this project | `string` | `""` 
| labels | Map of labels for project | `map(string)` | `{}` |
| name | The name for the project | `string` | n/a |
| project\_id | The ID to give the project. If not provided, the `name` will be used. | `string` | `""` |
| project\_name |   the project. name | `string` | `"prj-"` | 
| amount | A specified amount to use as the budget. | `string` |
| threshold_percent | Send an alert when this threshold is exceeded. This is a 1.0-based percentage, so 0.5 = 50%. Must be >= 0. | `string` |



