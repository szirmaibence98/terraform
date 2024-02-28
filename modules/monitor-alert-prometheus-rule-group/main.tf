resource "azurerm_monitor_alert_prometheus_rule_group" "example" {
  name                  = var.name
  location              = var.location
  resource_group_name   = var.resource_group_name
  cluster_name          = var.cluster_name
  scopes                = [var.kubernetes_cluster_id]

  dynamic "rule" {
    for_each = var.rules
    content {
      enabled    = rule.value.enabled
      expression = rule.value.expression
      labels     = rule.value.labels != null ? rule.value.labels : {}

      # For record rules
      if rule.value.record != null {
        record = rule.value.record
      }

      # For alert rules
      if rule.value.alert != null {
        alert      = rule.value.alert
        for        = rule.value.for
        severity   = rule.value.severity
        dynamic "action" {
          for_each = rule.value.action_group_id != null ? [1] : []
          content {
            action_group_id = rule.value.action_group_id
          }
        }
        dynamic "alert_resolution" {
          for_each = rule.value.auto_resolved != null ? [1] : []
          content {
            auto_resolved   = rule.value.auto_resolved
            time_to_resolve = rule.value.time_to_resolve
          }
        }
        annotations = rule.value.annotations != null ? rule.value.annotations : {}
      }
    }
  }

  tags = var.tags
}
