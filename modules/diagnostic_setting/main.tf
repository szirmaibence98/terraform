resource "azurerm_monitor_diagnostic_setting" "resource_monitoring" {
  name                       = "${var.resource_name}-monitoring"
  target_resource_id         = var.target_resource_id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  dynamic "log" {
    for_each = { for lg in var.logs_to_enable : lg.category => lg }
    content {
      category = log.value.category
      enabled  = log.value.enabled

      retention_policy {
        enabled = false
      }
    }
  }

  dynamic "metric" {
    for_each = { for mt in var.metrics_to_enable : mt.category => mt }
    content {
      category = metric.value.category
      enabled  = metric.value.enabled

      retention_policy {
        enabled = false
      }
    }
  }
}
