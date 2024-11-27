variable "region" {
  type        = string
  description = "Region of the all the resource will be created"
}

variable "network" {
  type        = string
  description = "Region of the all the resource will be created"
}
variable "static_ip_name" {
  type        = string
  description = "Gateway static ip name"
}


variable "gateway_name" {
  type        = string
  description = "Region of the all the resource will be created"
}
# variable "peer_ip" {
#   type        = string
#   description = "Region of the all the resource will be created"
# }

# variable "shared_secret" {
#   type        = string
#   description = "Region of the all the resource will be created"
# }


variable "gcp_project" {
  type        = string
  description = "project id where we want to craete a vpn "

}
# variable "remote_traffic_selector" {
#   type        = list(string)
#   description = "project id where we want to craete a vpn "

# }

variable "tunnel" {
  description = "List of vpcs which needs to be created. alongwith their detail"
  type = list(object({
    tunnel_name             = string
    peer_ip                 = string
    shared_secret           = string
    remote_traffic_selector = list(string)
  }))
}
