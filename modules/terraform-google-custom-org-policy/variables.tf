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



variable "parent" {
  description = "The parent resource of the constraint. For example, 'organizations/12345678'."
}

variable "name" {
  description = "The name of the custom constraint."
}

variable "display_name" {
  description = "The display name for the custom constraint."
}

variable "description" {
  description = "The description of the custom constraint."
}

variable "action_type" {
  description = "The action enforced by this constraint. Allowed values are DENY or ALLOW."
}

variable "condition" {
  description = "The condition expression that the policy is evaluated against."
}

variable "method_types" {
  description = "The method types associated with the policy."
  type        = list(string)
}

variable "resource_types" {
  description = "The resource types that this constraint applies to."
  type        = list(string)
}
variable "exclude_folders" {
  type    = list(string)
  # default =["folders/710979023460","folders/532400064872","folders/387169242534","folders/44818266739","folders/205704338860","folders/683471431769","folders/802814321475","folders/235579680024","folders/458824444267","folders/197127642604","folders/408253577634"]
  default =["folders/710979023460"]
}

