resource "azurerm_dashboard_grafana" "grafana" {
  name                = var.grafana_name
  resource_group_name = var.resource_group_name
  location            = var.grafana_location

  identity {
    type = "SystemAssigned"
  }

  azure_monitor_workspace_integrations {
    resource_id = var.azure_monitor_workspace_id
  }
}


