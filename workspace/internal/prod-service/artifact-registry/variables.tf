variable "artifact_registry" {
  type = list(object({
    location    = optional(string)
    id          = string
    description = optional(string)
    format      = optional(string)
    labels      = optional(map(string))
    project_id  = optional(string)
    iam         = optional(map(list(string)))

  }))
}
