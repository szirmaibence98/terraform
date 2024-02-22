resource "azurerm_subnet" "subnet" {
  for_each = { for s in var.subnets : s.name => s }

  name                 = each.value.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = each.value.address_prefixes

  dynamic "delegation" {
    for_each = each.value.delegate_to_service ? [each.value.service_delegation_type] : []
    content {
      name = "delegation"
      service_delegation {
        name    = delegation.key  # Use the type from the dynamic block key
        actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
      }
    }
  }
}

