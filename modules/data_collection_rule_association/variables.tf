variable "name" {
  description = "The name of the data collection rule association"
  type        = string
}

variable "target_resource_id" {
  description = "The ID of the target resource to associate with the data collection rule"
  type        = string
}

variable "data_collection_rule_id" {
  description = "The ID of the data collection rule to associate"
  type        = string
}

variable "description" {
  description = "A description of the data collection rule association"
  type        = string
  default     = "Association of data collection rule."
}

