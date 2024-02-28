variable "name" {
  description = "The name of the alert rule group."
  type        = string
}

variable "location" {
  description = "The location of the alert rule group."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "cluster_name" {
  description = "The name of the Kubernetes cluster."
  type        = string
}

variable "workspace_id" {
  description = "The ID of the Log Analytics Workspace."
  type        = string
}

variable "kubernetes_cluster_id" {
  description = "The ID of the Kubernetes cluster."
  type        = string
}

variable "rules" {
  description = "A list of rule definitions, including both alert and record rules."
  type = list(object({
    enabled    = bool
    expression = string
    record     = optional(string)
    alert      = optional(string)
    for        = optional(string)
    severity   = optional(number)
    action_group_id = optional(string)
    annotations = optional(map(string))
    labels      = optional(map(string))
  }))
  default = []
}


variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
