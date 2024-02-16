output "workspace_id" {
  value = azurerm_log_analytics_workspace.workspace.id
}

output "workspace_primary_shared_key" {
  value     = azurerm_log_analytics_workspace.workspace.primary_shared_key
  sensitive = true
}
