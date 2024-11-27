/**
 * Copyright 2020 Google LLC
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

variable "project" {
  description = "The project to deploy to, if not set the default provider project is used."
  type        = string
}

variable "policy_name" {
  description = "GCP policy name"
}

variable "waf_rules" {
  description = "rules"
}

variable "security_policies" {
  description = "rules"
}

variable "armor_description" {
  description = "GCP policy description"
}
variable "type" {
  description = "GCP policy type"
}

