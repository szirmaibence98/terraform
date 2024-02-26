resource "azurerm_monitor_workspace" "amw" {
  name                = var.monitor_workspace_name
  resource_group_name = var.resource_group_name
  location            = var.location
}
