output "workspace_id" {
  value = azurerm_log_analytics_workspace.example.customer_id
}


output "workspace_primary_shared_key" {
  value     = azurerm_log_analytics_workspace.example.primary_shared_key
  sensitive = true
}
