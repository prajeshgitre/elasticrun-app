# # #vpc variables
# variable "vpc_list" {
#   description = "List of vpcs which needs to be created. alongwith their detail"
#   type = map(object({
#     vpc_name                               = string
#     project_id                             = string
#     delete_default_internet_gateway_routes = bool
#     subnets                                = list(map(string))
#     secondary_ranges                       = map(list(object({ range_name = string, ip_cidr_range = string })))
#   }))
# }


variable "cloud_nat" {
  description = "variable to create cloud nat "
  type = list(object({
    project_id                          = string
    router_network                      = string
    region                              = string
    nat_name                            = string
    router_name                         = string
    static_ip_name                      = list(string)
    create_router                       = bool
    log_config_enable                   = bool
    log_config_filter                   = string
    enable_dynamic_port_allocation      = bool
    source_subnetwork_ip_ranges_to_nat  = string
    enable_endpoint_independent_mapping = bool
    min_ports_per_vm                    = number
    subnetworks = list(object({
      name                     = string,
      source_ip_ranges_to_nat  = list(string)
      secondary_ip_range_names = list(string)
    }))
  }))
  default = []
}

variable "reserve_static_ip" {
  description = "reserve ip"
  type = list(object({
    name         = string
    project_id   = string
    region       = string
    address_type = string
    subnetwork = optional(string)
  }))
}
# variable "nat_static_ip" {
#   description = "reserve ip"
#   type = list(object({
#     name         = string
#     project_id   = string
#     region       = string
#     address_type = string
#   }))
# }


# variable "firewall_rules_list" {
#   type = map(object({
#     project_id   = string
#     network_name = string
#     rules = list(object({
#       name                    = string
#       description             = string
#       direction               = string
#       priority                = number
#       ranges                  = list(string)
#       source_tags             = list(string)
#       source_service_accounts = list(string)
#       target_tags             = list(string)
#       target_service_accounts = list(string)
#       allow = list(object({
#         protocol = string
#         ports    = list(string)
#       }))
#       deny = list(object({
#         protocol = string
#         ports    = list(string)
#       }))
#       log_config = object({
#         metadata = string
#       })
#     }))
#   }))
# }

# # #cloud dns variables
# variable "cloud_dns" {
#   description = "List of Private dns"
#   type = list(object({
#     type   = string
#     name   = string
#     domain = string
#     recordsets = list(object({
#       name    = string,
#       type    = string,
#       ttl     = number,
#       records = list(string)
#     }))
#   }))
#   default = []
# }

# variable "dns_project_id" {
#   type        = string
#   description = "Project id of the VPC"
# }

# variable "dns_network" {
#   type        = string
#   description = "vpc name for cloud dns"
# }