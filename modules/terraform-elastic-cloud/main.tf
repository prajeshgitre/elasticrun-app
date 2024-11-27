resource "ec_deployment" "instance" {
  name                   = var.deployment_name
  region                 = var.region
  version                = var.elastic_cloud_deployment_version
  deployment_template_id = var.deployment_template_id

  elasticsearch = {
    hot = {
      size        = var.hot_size
      zone_count  = var.hot_zone_count
      autoscaling = {}
    }

    cold = {
      size        = var.cold_size
      zone_count  = var.cold_zone_count
      autoscaling = {}
    }

    frozen = {
      size        = var.frozen_size
      zone_count  = var.frozen_zone_count
      autoscaling = {}
    }


  }
  kibana = {
    size       = var.kibana_size
    zone_count = var.kibana_zone_count
  }

  traffic_filter = [ec_deployment_traffic_filter.gcp_psc.id]

  lifecycle {
    ignore_changes = [elasticsearch]
  }
}



resource "ec_deployment_traffic_filter" "gcp_psc" {
  name   = var.traffic_filter_name
  region = var.region
  type   = "gcp_private_service_connect_endpoint"

  rule {
    source = var.traffic_filter_source
  }
}
