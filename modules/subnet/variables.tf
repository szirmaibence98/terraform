variable "resource_group_name" {
  description = "Resource group name where the subnet will be created"
  type        = string
}

variable "virtual_network_name" {
  description = "Name of the Virtual Network the subnet belongs to"
  type        = string
}


variable "subnets" {
  description = "A list of subnet configurations."
  type = list(object({
    name                 = string
    address_prefixes     = list(string)
    nsg_id               = optional(string)
    delegate_to_service  = bool
    service_delegation_type = string
  }))
}
