# terraform {
#   required_providers {
#     google = {
#       source  = "hashicorp/google"
#       version = "4.51.0"
#     }
#     google-beta = {
#       source  = "hashicorp/google-beta"
#       version = "~> 3.30"
#     }
#   }
#   provider_meta "google" {
#     module_name = "blueprints/terraform/terraform-google-folders/v3.1.0"
#   }
# }