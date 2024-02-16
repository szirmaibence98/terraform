variable "resource_group_name" {
  description = "Resource group name where the subnet will be created"
  type        = string
}

variable "virtual_network_name" {
  description = "Name of the Virtual Network the subnet belongs to"
  type        = string
}


variable "subnets" {
  description = "A list of subnets and their properties"
  type = list(object({
    name             = string
    address_prefixes = list(string)
    nsg_id           = optional(string) // Make nsg_id optional
  }))
}
