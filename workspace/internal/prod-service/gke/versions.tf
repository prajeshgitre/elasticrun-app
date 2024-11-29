# terraform {
#   required_version = ">=1.3"

#   required_providers {
#     google = {
#       source  = "hashicorp/google"
#       version = "5.38.0"
#     }
#     google-beta = {
#       source  = "hashicorp/google-beta"
#       version = "5.38.0"
#     }
#     kubernetes = {
#       source  = "hashicorp/kubernetes"
#       version = "~> 2.10"
#     }
#     random = {
#       source  = "hashicorp/random"
#       version = ">= 2.1"
#     }
#   }
#   provider_meta "google" {
#     module_name = "blueprints/terraform/terraform-google-kubernetes-engine:private-cluster/v31.1.0"
#   }
# }
