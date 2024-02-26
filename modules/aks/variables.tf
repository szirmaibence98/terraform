variable "cluster_name" {
  description = "The name of the AKS cluster."
  type        = string
}

variable "location" {
  description = "The Azure location where the AKS cluster will be deployed."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the AKS cluster."
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix specified when creating the AKS cluster."
  type        = string
}

variable "agent_count" {
  description = "The number of agents (VMs) to create in the node pool."
  type        = number
}



variable "annotations_allowed" {
  description = "List of annotations to be captured for AKS monitoring."
  type        = string
  default     = null
}

variable "labels_allowed" {
  description = "List of labels to be captured for AKS monitoring."
  type        = string
  default     = null
}




