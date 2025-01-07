# *****************************************************
# cloud-armor
# *****************************************************

variable "list_of_cloud_armor" {
  description = "variables for cloud armor"
  type = list(object({
    project_id                           = string
    name                                 = string
    description                          = string
    default_rule_action                  = string
    type                                 = string
    layer_7_ddos_defense_enable          = bool
    layer_7_ddos_defense_rule_visibility = string
    custom_rules                 = map(any)
    security_rules = map(any)
  }))
}