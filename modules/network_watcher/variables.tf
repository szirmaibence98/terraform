variable "name" {
  type        = string
  description = "The name of the Network Watcher instance."
}

variable "location" {
  type        = string
  description = "The location where the network watcher will be deployed."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group that the network watcher will be associated with."
}
