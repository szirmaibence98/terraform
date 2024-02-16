resource "azurerm_network_watcher_flow_log" "example" {
  // Assuming count or for_each is used to handle multiple NSG IDs
  for_each             = toset(var.nsg_ids)
  name                 = "flowLog-${each.key}" // Use each.key or each.value as appropriate
  network_watcher_name = var.network_watcher_name
  resource_group_name  = var.resource_group_name

  network_security_group_id = each.value // Adjust based on your iteration method
  storage_account_id        = var.storage_account_id
  enabled                   = true

  retention_policy {
    enabled = true
    days    = 30
  }

  traffic_analytics {
    enabled               = true
    workspace_id          = var.log_analytics_workspace_id
    workspace_region      = var.location // Ensure this is provided as a variable if required
    workspace_resource_id = var.log_analytics_workspace_resource_id
  }
}
