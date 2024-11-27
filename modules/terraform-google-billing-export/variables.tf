variable "dataset_name" {
  description = "Friendly name for the dataset being provisioned."
  type        = string
  default     = null
}

variable "project_id" {
  description = "the project id in which dataset need to create"
  type        = string
}

variable "description" {
  description = "dataset description."
  type        = string
  default     = null
}

variable "region" {
  description = "The regional location for the dataset"
  type        = string
  default     = ""
}

variable "billing_account" {
  description = "ID of the billing account"
  type        = string
}

variable "billing_sink_name" {
  description = "billing account sink name"
  type        = string
  default     = null
}

variable "default_encryption_configuration" {
  description = "A Cloud KMS key that will be used to encrypt objects inserted into this bucket"
  type = object({
    kms_key_name = string
  })
  default = null
}