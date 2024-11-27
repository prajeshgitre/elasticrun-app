resource "google_org_policy_custom_constraint" "constraint" {
  parent         = var.parent
  name           = var.name
  display_name   = var.display_name
  description    = var.description
  action_type    = var.action_type
  condition      = var.condition
  method_types   = var.method_types
  resource_types = var.resource_types
}

resource "google_org_policy_policy" "bool" {

  name   = "${var.parent}/policies/${google_org_policy_custom_constraint.constraint.name}"
  parent = var.parent

  spec {
    rules {
      enforce = "TRUE"
    }
  }
}

# resource "google_folder_organization_policy" "folder_policy_list_deny_values" {
#   count = length(var.exclude_folders) > 0 ? length(var.exclude_folders) : 0

#   folder     = var.exclude_folders[count.index]
#   constraint = google_org_policy_custom_constraint.constraint.name

#   list_policy {
#     deny {
#       values = []
#     }
#   }
# }





# resource "google_folder_organization_policy" "folder_policy_list_deny_values" {
#   count = length(var.exclude_folders) > 0 ? length(var.exclude_folders) : 0

#   folder     = var.exclude_folders[count.index]
#   constraint = google_org_policy_custom_constraint.constraint.name

#   list_policy {
#     deny {
#       values = []
#     }
#   }
# }
