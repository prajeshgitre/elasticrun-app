variable "deployment_name" {
  description = "Optional name for the deployment"
  type        = string
  default     = "my_example_deployment"
}

variable "region" {
  description = "Region where the deployment will be created"
  type        = string
}

variable "elastic_cloud_deployment_version" {
  description = "Version of Elasticsearch to use"
  type        = string
}

variable "deployment_template_id" {
  description = "ID of the deployment template"
  type        = string
}

variable "hot_size" {
  description = "Size of the hot tier"
  type        = string
}

variable "hot_zone_count" {
  description = "Number of zones for the hot tier"
  type        = number
}

variable "cold_size" {
  description = "Size of the cold tier"
  type        = string
}

variable "cold_zone_count" {
  description = "Number of zones for the cold tier"
  type        = number
}

variable "frozen_size" {
  description = "Size of the frozen tier"
  type        = string
}

variable "frozen_zone_count" {
  description = "Number of zones for the frozen tier"
  type        = number
}

variable "kibana_size" {
  description = "Size of the Kibana instance"
  type        = string
}

variable "kibana_zone_count" {
  description = "Number of zones for the Kibana instance"
  type        = number
}

variable "traffic_filter_name" {
  description = "traffic_filter_name"
  type        = string
}

variable "traffic_filter_source" {
  description = "traffic_filter_name"
  type        = string
}
