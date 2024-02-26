variable "location" {
  description = "The Azure region where resources will be created."
  type        = string
  default     = "West Europe"
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
  default     = "daimler"
}

variable "environment" {
  description = "The deployment environment (e.g., dev, prod)."
  type        = string
}




# AKS

variable "cluster_name" {
  description = "The name of the AKS cluster"
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix for the AKS cluster"
  type        = string
}

variable "agent_count" {
  description = "The number of agent nodes for the AKS cluster"
  type        = number
}


