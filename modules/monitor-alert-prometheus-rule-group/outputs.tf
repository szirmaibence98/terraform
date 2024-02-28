output "alert_rule_group_id" {
  description = "The ID of the alert rule group."
  value       = azurerm_monitor_alert_prometheus_rule_group.example.id
}
