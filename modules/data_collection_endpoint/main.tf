resource "azurerm_monitor_data_collection_endpoint" "dce" {
  name                = "MSProm-${var.cluster_name}"
  resource_group_name = var.resource_group_name
  location            = var.location
  kind                = "Linux"
}