/**
 * Copyright 2018 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed underesource "google_monitoring_notification_channel" "notification_channel" {
  display_name = "Email Notification Channel"
  type         = var.notification_type
  project = var.notification_project
  labels = {
    email_address = var.email_address
  }
}r the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

# terraform {
#   required_providers {
#     google = {
#       source  = "hashicorp/google"
#       version = "4.51.0"
#     }
#   }
#   provider_meta "google" {
#     module_name = "blueprints/terraform/terraform-google-project-factory/v14.2.0"
#   }
#   provider_meta "google-beta" {
#     module_name = "blueprints/terraform/terraform-google-project-factory/v14.2.0"
#   }
# }