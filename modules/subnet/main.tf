resource "azurerm_subnet" "subnet" {
  for_each = { for s in var.subnets : s.name => s }

  name                 = each.value.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = each.value.address_prefixes

  dynamic "delegation" {
    for_each = each.value.nsg_id != null ? [1] : []
    content {
      name = "delegation"
      service_delegation {
        name = "Microsoft.ContainerInstance/containerGroups"
        actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
      }
    }
  }
}
