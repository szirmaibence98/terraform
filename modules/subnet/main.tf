resource "azurerm_subnet" "subnet" {
  for_each = { for s in var.subnets : s.name => s }

  name                 = each.value.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = each.value.address_prefixes

  if each.value.delegate_to_service {
    delegation {
      name = "aciDelegation"
      service_delegation {
        name    = each.value.service_delegation_type
        actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
      }
    }
  }
}
