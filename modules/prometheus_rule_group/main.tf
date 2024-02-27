resource "azurerm_monitor_alert_prometheus_rule_group" "node_recording_rules_rule_group" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  cluster_name        = var.cluster_name
  description         = "Node Recording Rules Rule Group"
  rule_group_enabled  = true
  interval            = "PT1M"
  scopes              = [var.workspace_id, var.kubernetes_cluster_id]

  dynamic "rule" {
    for_each = var.rules

    content {
      enabled    = rule.value["enabled"]
      record     = rule.value["record"]
      expression = rule.value["expression"]
    }
  }
}