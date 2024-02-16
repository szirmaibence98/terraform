resource "azurerm_network_watcher" "network_watcher" {
  name                = "nw-${var.location}"
  location            = var.location
  resource_group_name = var.resource_group_name
}
