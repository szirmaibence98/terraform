resource "azurerm_monitor_alert_prometheus_rule_group" "example" {
  name                  = var.name
  location              = var.location
  resource_group_name   = var.resource_group_name
  cluster_name          = var.cluster_name
  scopes                = [var.workspace_id, var.kubernetes_cluster_id]

  dynamic "rule" {
    for_each = [for r in var.rules : r if r.record != null]
    content {
      enabled    = rule.value.enabled
      expression = rule.value.expression
      record     = rule.value.record
      labels     = rule.value.labels != null ? rule.value.labels : {}
    }
  }

  dynamic "rule" {
    for_each = [for r in var.rules : r if r.alert != null]
    content {
      alert      = rule.value.alert
      enabled    = rule.value.enabled
      expression = rule.value.expression
      for        = rule.value.for
      severity   = rule.value.severity
      labels     = rule.value.labels != null ? rule.value.labels : {}

      dynamic "action" {
        for_each = rule.value.action_group_id != null ? [rule.value] : []
        content {
          action_group_id = rule.value.action_group_id
        }
      }

      dynamic "alert_resolution" {
      for_each = rule.value.auto_resolved != null ? [rule.value] : []
      content {
          auto_resolved   = rule.value.auto_resolved
          time_to_resolve = rule.value.time_to_resolve
      }
      }


      annotations = rule.value.annotations != null ? rule.value.annotations : {}
    }
  }

  tags = var.tags
}
