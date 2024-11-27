locals {
  routes = flatten([
    for tunnel in toset(var.tunnel) : [
      for ip in tunnel.remote_traffic_selector : {
        tunnel = tunnel.tunnel_name
        ip     = ip
        index  = join("${tunnel.tunnel_name}", split("/", join("", split(".", cidrsubnet(ip, 0, 0)))))

      }
    ]
  ])
}


# locals {
#   subnet_cidr = "10.0.1.0/24"
#   subnet_parts = split(".", cidrsubnet(local.subnet_cidr, 0, 0))
#   output_value = tonumber(join("", local.subnet_parts))
# }


data "google_compute_network" "trusted-user" {
  name    = var.network
  project = var.gcp_project
}

# ###-----*** DC1 VPN connection  ****--------######

resource "google_compute_address" "vpn_static_ip" {
  name    = var.static_ip_name
  project = var.gcp_project
  region  = var.region
}

resource "google_compute_vpn_gateway" "target_gateway" {
  name    = var.gateway_name
  network = data.google_compute_network.trusted-user.id
  project = var.gcp_project
  region  = var.region
}


resource "google_compute_forwarding_rule" "fr_esp" {
  name        = "fr-esp"
  ip_protocol = "ESP"
  ip_address  = google_compute_address.vpn_static_ip.address
  target      = google_compute_vpn_gateway.target_gateway.id
  project     = var.gcp_project
  region      = var.region
}

resource "google_compute_forwarding_rule" "fr_udp500" {
  name        = "fr-udp500"
  ip_protocol = "UDP"
  port_range  = "500"
  ip_address  = google_compute_address.vpn_static_ip.address
  target      = google_compute_vpn_gateway.target_gateway.id
  project     = var.gcp_project
  region      = var.region
}

resource "google_compute_forwarding_rule" "fr_udp4500" {
  name        = "fr-udp4500"
  ip_protocol = "UDP"
  port_range  = "4500"
  ip_address  = google_compute_address.vpn_static_ip.address
  target      = google_compute_vpn_gateway.target_gateway.id
  project     = var.gcp_project
  region      = var.region
}

resource "google_compute_vpn_tunnel" "tunnel1" {
  for_each                = { for i in var.tunnel : i.tunnel_name => i }
  name                    = each.value.tunnel_name
  peer_ip                 = each.value.peer_ip
  shared_secret           = each.value.shared_secret
  target_vpn_gateway      = google_compute_vpn_gateway.target_gateway.id
  project                 = var.gcp_project
  ike_version             = 2
  remote_traffic_selector = each.value.remote_traffic_selector
  local_traffic_selector  = ["0.0.0.0/0"]
  depends_on              = [google_compute_forwarding_rule.fr_esp, google_compute_forwarding_rule.fr_udp500, google_compute_forwarding_rule.fr_udp4500]
}

# resource "google_compute_route" "route" {
#   for_each = google_compute_vpn_tunnel.tunnel
#   name                = "rt-${var.gateway_name}-${each.key}"
#   project             = var.gcp_project
#   network             = data.google_compute_network.trusted-user.id
#   dest_range          = each.value.remote_traffic_selector[count.index]
#   priority            = 1000
#   next_hop_vpn_tunnel = each.value.id
# }

# resource "google_compute_route" "route" {
#   for_each    = { for tunnel in google_compute_vpn_tunnel.tunnel1 : tunnel.key => tunnel.value.remote_traffic_selector }

#   name                = "rt-${var.gateway_name}-${each.key}"
#   project             = var.gcp_project
#   network             = data.google_compute_network.trusted-user.id
#   dest_range          = each.value[0]
#   priority            = 1000
#   next_hop_vpn_tunnel = google_compute_vpn_tunnel.tunnel1[each.key].id
# }


resource "google_compute_route" "route" {
  for_each            = { for i in local.routes : i.index => i }
  name                = "rt-${each.value.index}"
  project             = var.gcp_project
  network             = data.google_compute_network.trusted-user.id
  dest_range          = each.value.ip
  priority            = 1000
  next_hop_vpn_tunnel = google_compute_vpn_tunnel.tunnel1["${each.value.tunnel}"].id
  #google_compute_vpn_tunnel["${each.value.tunnel}"].tunnel1.id
}

