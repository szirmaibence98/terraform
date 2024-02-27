output "grafana_id" {
  value = azurerm_dashboard_grafana.grafana.id
}

output "principal_id" {
  value = azurerm_dashboard_grafana.grafana.identity.0.principal_id
}
