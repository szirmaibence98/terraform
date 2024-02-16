resource "azurerm_network_watcher_flow_log" "example" {
  count               = length(var.nsg_ids)
  name                = "example-flow-log-${count.index}" // Adjust this name as needed
  network_watcher_name = var.network_watcher_name
  resource_group_name  = var.resource_group_name

  network_security_group_id = var.nsg_ids[count.index]
  storage_account_id        = var.storage_account_id
  enabled                   = true

  retention_policy {
    enabled = true
    days    = 30
  }

  traffic_analytics {
    enabled               = true
    workspace_id          = var.log_analytics_workspace_id
    workspace_region      = var.location
    workspace_resource_id = var.log_analytics_workspace_resource_id
  }
}
