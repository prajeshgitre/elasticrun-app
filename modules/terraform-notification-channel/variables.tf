variable "email" {
  type    = list(string)
  default = []
}

variable "pagerduty" {
  type    = list(string)
  default = []
}

variable "webhook" {
  type    = list(string)
  default = []
}

variable "labels" {
  description = "The list of labels (key/value pairs) to be applied to the channel"
  type        = map(string)
  default     = null
}

variable "project" {
  type    = string
  default = null
}
