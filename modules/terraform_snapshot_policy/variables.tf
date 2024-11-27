variable "disk_zone_map" {
  description = "Map of disk names to their corresponding zones"
  type        = map(string)
  default     = {}
}

variable "project" {
  description = "project"
  type        = string

}