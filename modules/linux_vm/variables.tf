variable "resource_group_name" {
  description = "The name of the resource group in which to create the VM"
}

variable "location" {
  description = "The Azure location where the VM should be created"
}

variable "vm_name" {
  description = "The name of the VM"
  default     = "myLinuxVM"
}

variable "vm_size" {
  description = "The size of the VM"
  default     = "Standard_B1ls" # Smallest and cheapest option, suitable for testing
}

variable "admin_username" {
  description = "Administrator username for VM access"
}

variable "admin_password" {
  description = "Administrator password for VM access"
}

variable "network_interface_id" {
  description = "The ID of the network interface to attach to the VM"
}

variable "log_analytics_workspace_id" {
  description = "Optional: The ID of the Log Analytics Workspace for diagnostics settings."
  type        = string
  default     = "" # Make it optional
}
