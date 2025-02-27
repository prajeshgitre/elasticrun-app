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
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

output "project_id" {
  description = "Project id (depends on services)."
  value       = trimprefix(google_project.project.id, "projects/")
  depends_on  = [google_project_service.project_services]
}

output "name" {
  description = "Name (depends on services)."
  value       = google_project.project.name
  depends_on  = [google_project_service.project_services]
}

output "number" {
  description = "Project number (depends on services)."
  value       = google_project.project.number
  depends_on  = [google_project_service.project_services]
}

output "cloudsvc_service_account" {
  description = "Cloud services service account (depends on services)."
  value       = local.cloudsvc_service_account
  depends_on  = [google_project_service.project_services]
}

output "gce_service_account" {
  description = "Default GCE service account (depends on services)."
  value       = local.gce_service_account
  depends_on  = [google_project_service.project_services]
}

output "gke_service_account" {
  description = "Default GKE service account (depends on services)."
  value       = local.gke_service_account
  depends_on  = [google_project_service.project_services]
}

output "custom_roles" {
  description = "Ids of the created custom roles."
  value       = google_project_iam_custom_role.roles[*].role_id
}