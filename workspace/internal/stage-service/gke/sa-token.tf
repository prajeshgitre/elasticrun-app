# ######################Service Account Token Data Block######################

# data "google_service_account_access_token" "service_account" {
#   count    = var.project.service_account == null ? 0 : 1
#   lifetime = var.access_token_expiry

#   target_service_account = var.project.service_account
#   scopes = [
#     "https://www.googleapis.com/auth/cloud-platform",
#   ]
# }

# ############################# Provider Block #############################
# provider "google" {
#   access_token = var.project.service_account == null ? null : data.google_service_account_access_token.service_account[0].access_token
#   project      = var.project.name
#   alias        = "project"
# }

# provider "google-beta" {
#   access_token = var.project.service_account == null ? null : data.google_service_account_access_token.service_account[0].access_token
#   project      = var.project.name
#   alias        = "project-beta"
# }

# #############################Service Account Token Variables#############################
# variable "access_token_expiry" {
#   type    = string
#   default = "3600s"
# }

# variable "project" {
#   type = object({
#     name = optional(string), service_account = optional(string)
#   })
# }
