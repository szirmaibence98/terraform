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

variable "metric_annotations_allowlist" {
  description = "List of allowed metric annotations."
  type        = list(string)
  default     = []
}

variable "metric_labels_allowlist" {
  description = "List of allowed metric labels."
  type        = list(string)
  default     = []
}