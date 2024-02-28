resource "azurerm_monitor_alert_prometheus_rule_group" "example" {
  name                  = var.name
  location              = var.location
  resource_group_name   = var.resource_group_name
  cluster_name          = var.cluster_name
  scopes                = [var.kubernetes_cluster_id]

  dynamic "rule" {
   for_each = [for r in var.rules: r if r.record != null]
    content {
      enabled    = rule.value.enabled
      expression = rule.value.expression
      record     = rule.value.record
      labels     = lookup(rule.value, "labels", {})
    }
  }


  dynamic "rule" {
    for_each = [for r in var.rules: r if r.alert != null]
    content {
      alert      = rule.value.alert
      enabled    = rule.value.enabled
      expression = rule.value.expression
      for        = rule.value.for
      severity   = rule.value.severity

      dynamic "action" {
        for_each = lookup(rule.value, "action", [])
        content {
          action_group_id = action.value.action_group_id
        }
      }

      dynamic "alert_resolution" {
        for_each = lookup(rule.value, "alert_resolution", [])
        content {
          auto_resolved   = alert_resolution.value.auto_resolved
          time_to_resolve = alert_resolution.value.time_to_resolve
        }
      }

      annotations = lookup(rule.value, "annotations", {})
      labels      = lookup(rule.value, "labels", {})
    }
  }

  tags = var.tags
}
