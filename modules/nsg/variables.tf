variable "nsg_name" {
  type        = string
  description = "The name of the network security group"
}

variable "location" {
  type        = string
  description = "The location of the NSG"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "security_rules" {
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  description = "The security rules for the NSG"
}


variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource"
  default     = {}
}
