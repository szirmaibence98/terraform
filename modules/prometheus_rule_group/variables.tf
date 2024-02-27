variable "name" {
  type        = string
}

variable "cluster_name" {
  type        = string
  description = "The name of the cluster."
}

variable "location" {
  type        = string
  description = "The Azure region where the resources will be created."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group."
}

variable "workspace_id" {
  type        = string
  description = "The ID of the Log Analytics Workspace."
}

variable "kubernetes_cluster_id" {
  type        = string
  description = "The ID of the Kubernetes Cluster."
}

variable "rules" {
  description = "A list of maps defining the alert rules."
  type        = list(map(any))
  default     = []
}
