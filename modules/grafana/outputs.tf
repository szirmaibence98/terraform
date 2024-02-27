output "grafana_id" {
  value = azurerm_dashboard_grafana.grafana.id
}

output "principal_id" {
  value = azurerm_service_principal.grafana.principal_id
}
