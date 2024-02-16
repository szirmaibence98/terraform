resource "azurerm_subnet" "subnet" {
  for_each = { for s in var.subnets : s.name => s }

  name                 = each.value.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = each.value.address_prefixes
  network_security_group_id = each.value.nsg_id 
  // Depending on your requirements, you might also want to include service endpoints or delegation here.
}
