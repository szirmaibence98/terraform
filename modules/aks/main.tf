resource "azurerm_kubernetes_cluster" "k8s" {
  location            = var.location
  name                = var.cluster_name
  resource_group_name = var.resource_group_name

  dns_prefix = var.dns_prefix

  tags = {
    Environment = "Development"
  }

  default_node_pool {
    name       = "agentpool"
    vm_size    = "Standard_D2_v2"
    node_count = var.agent_count
  }


  monitor_metrics {
    annotations_allowed = var.annotations_allowed
    labels_allowed      = var.labels_allowed
#    annotations_allowed = null
#    labels_allowed      = null
  }

  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"
  }

  identity {
    type = "SystemAssigned"
  }
}
