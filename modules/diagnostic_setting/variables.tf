variable "target_resource_id" {
  description = "The ID of the target resource to monitor."
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics workspace."
  type        = string
}

variable "logs_to_enable" {
  description = "List of log categories to enable."
  type        = list(object({
    category = string
    enabled  = bool
  }))
  default     = []
}

variable "metrics_to_enable" {
  description = "List of metric categories to enable."
  type        = list(object({
    category = string
    enabled  = bool
  }))
  default     = []
}

variable "resource_name" {
  description = "The name of the target resource for diagnostic settings."
  type        = string
}
