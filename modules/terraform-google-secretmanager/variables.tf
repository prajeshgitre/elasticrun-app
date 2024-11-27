variable "project_id" {
  description = "The GCP project where secrets will be created."
  type        = string
  default     = ""
}

variable "secret_id" {
  description = "Name of the secrets to be created"
  type        = string
  default     = ""
}

variable "location" {
  description = "The GCP region where secrets will be created."
  type        = string
  default     = ""
}

variable "service" {
  description = "Service_identity"
  type        = string
  default     = ""
}

variable "kms_key_name" {
  description = "Customer managed encryption key to be used"
  type        = string
  default     = ""
}