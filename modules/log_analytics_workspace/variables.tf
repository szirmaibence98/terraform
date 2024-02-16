variable "name" {
  type        = string
  description = "Specifies the name of the Log Analytics Workspace."
}

variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the Log Analytics workspace."
}

variable "sku" {
  type        = string
  description = "Specifies the SKU of the Log Analytics Workspace."
  default     = "PerGB2018"
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}
