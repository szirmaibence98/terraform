module "resource_group" {
  source   = "./modules/resource_group"
  name     = var.resource_group_name
  location = var.location
  tags = {
    Environment = var.environment
  }
}


module "vnet" {
  source              = "./modules/vnet"
  name                = "myVNet"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = module.resource_group.name
  tags = {
    Environment = var.environment
  }
}


module "subnets" {
  source               = "./modules/subnet"
  resource_group_name  = module.resource_group.name  
  virtual_network_name = module.vnet.name

  subnets = [
    {
      name                 = "subnet1"
      address_prefixes     = ["10.0.1.0/24"]
      nsg_id               = module.nsg.nsg_id
      delegate_to_service  = true
      service_delegation_type = "Microsoft.ContainerInstance/containerGroups"
    },
    {
      name                 = "subnet2"
      address_prefixes     = ["10.0.2.0/24"]
      nsg_id               = null
      delegate_to_service  = false
      service_delegation_type = "" 
    }
  ]

}


module "nsg" {
  source              = "./modules/nsg"
  nsg_name            = "myCustomNSG"
  location            = var.location
  resource_group_name = module.resource_group.name
  security_rules      = [
    {
      name                       = "allow-ssh"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "allow-http"
      priority                   = 110
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "allow-https"
      priority                   = 120
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  ]
  tags = {
    Environment = var.environment
  }
}




module "network_watcher" {
  source              = "./modules/network_watcher"
  name = "customNetworkWatcherName"
  location            = var.location
  resource_group_name = module.resource_group.name
}


module "nsg_flow_logs" {
  source               = "./modules/nsg_flow_logs"
  network_watcher_name = module.network_watcher.network_watcher_name
  resource_group_name  = module.resource_group.name
  storage_account_id   = module.storage_account.storage_account_id
  nsg_ids              = {
    "nsg1" = module.nsg.nsg_id
  }
  log_analytics_workspace_id          = module.log_analytics_workspace.workspace_id
  location                            = var.location
  log_analytics_workspace_resource_id = module.log_analytics_workspace.workspace_resource_id
}





module "storage_account" {
  source              = "./modules/storage_account"
  name                = "daimlerszirmai"
  resource_group_name = module.resource_group.name
  location            = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                = {
    Environment = var.environment
  }
}

module "log_analytics_workspace" {
  source              = "./modules/log_analytics_workspace"
  name                = "myloganalyticsworkspace"
  location            = var.location
  resource_group_name = module.resource_group.name
  sku                 = "PerGB2018"
  tags                = {
    Environment = var.environment
  }
}





module "network_interface" {
  source                = "./modules/network_interface"
  resource_group_name   = module.resource_group.name
  location              = var.location
  subnet_id             = module.subnets.subnet_ids["subnet2"]
  network_interface_name = "myLinuxVMNic"
  tags                  = {
    Environment = var.environment
  }
}

#module "linux_vm" {
#  source = "./modules/linux_vm"
#  resource_group_name    = module.resource_group.name
#  location               = var.location
#  vm_name                = "myLinuxVM"
#  vm_size                = "Standard_B1s"
#  admin_username         = "adminuser"
#  admin_password         = "SecurePassword123!"
#  network_interface_id   = module.network_interface.id
#  log_analytics_workspace_id = module.log_analytics_workspace.workspace_resource_id
#}


#module "vm_logging" {
#  source                      = "./modules/diagnostic_setting"
#  resource_name               = module.linux_vm.vm_name
#  target_resource_id          = module.linux_vm.vm_id
#  log_analytics_workspace_id  = module.log_analytics_workspace.workspace_resource_id
#  logs_to_enable              = []  # Adjust based on supported categories or leave empty if unsure
#  metrics_to_enable           = [
#    { category = "AllMetrics", enabled = true }
#  ]
#}





module "aks" {
  source              = "./modules/aks"
  cluster_name        = var.cluster_name
  location            = var.location
  resource_group_name = module.resource_group.name
  dns_prefix          = var.dns_prefix
  agent_count         = var.agent_count
  annotations_allowed = var.annotations_allowed
  labels_allowed      = var.labels_allowed
}



module "monitor_workspace" {
  source              = "./modules/monitor_workspace"
  monitor_workspace_name = "example-workspace"
  resource_group_name = module.resource_group.name
  location            = var.location
}

module "data_collection_endpoint" {
  source              = "./modules/data_collection_endpoint"
  cluster_name        = "yourClusterName"
  resource_group_name = module.resource_group.name
  location            = var.location
}


module "data_collection_rule" {
  source                       = "./modules/data_collection_rule"
  name_prefix                  = "MSProm"
  resource_group_name          = module.resource_group.name
  location                     = var.location
  data_collection_endpoint_id  = module.data_collection_endpoint.endpoint_id
  monitor_workspace_id         = module.monitor_workspace.workspace_id
  cluster_name                 = module.aks.cluster_name
}


module "data_collection_rule_association" {
  source                  = "./modules/data_collection_rule_association"
  name                    = "MSProm-${var.location}-${var.cluster_name}"
  target_resource_id      = module.aks.cluster_id
  data_collection_rule_id = module.data_collection_rule.data_collection_rule_id
  description             = "Association of data collection rule. Deleting this association will break the data collection for this AKS Cluster."
}


module "prometheus_rule_group" {
  source                = "./modules/prometheus_rule_group"
  name                  = "ruleseta"
  cluster_name          = "myCluster"
  location              = var.location
  resource_group_name   = module.resource_group.name
  workspace_id          = module.monitor_workspace.workspace_id
  kubernetes_cluster_id = module.aks.cluster_id


  rules = [
    {
      enabled    = true,
      record     = "instance:node_num_cpu:sum",
      expression = "count without (cpu, mode) (node_cpu_seconds_total{job=\"node\",mode=\"idle\"})"
    },
    {
      enabled    = true,
      record     = "instance:node_cpu_utilisation:rate5m",
      expression = "1 - avg without (cpu) (sum without (mode) (rate(node_cpu_seconds_total{job=\"node\", mode=~\"idle|iowait|steal\"}[5m])))"
    },
    {
      enabled    = true,
      record     = "instance:node_load1_per_cpu:ratio",
      expression = "(node_load1{job=\"node\"}/instance:node_num_cpu:sum{job=\"node\"})"
    },
    {
      enabled    = true,
      record     = "instance:node_memory_utilisation:ratio",
      expression = "1 - ((node_memory_MemAvailable_bytes{job=\"node\"} or (node_memory_Buffers_bytes{job=\"node\"} + node_memory_Cached_bytes{job=\"node\"} + node_memory_MemFree_bytes{job=\"node\"} + node_memory_Slab_bytes{job=\"node\"}))/node_memory_MemTotal_bytes{job=\"node\"})"
    },
    {
      enabled    = true,
      record     = "instance:node_vmstat_pgmajfault:rate5m",
      expression = "rate(node_vmstat_pgmajfault{job=\"node\"}[5m])"
    },
    {
      enabled    = true,
      record     = "instance_device:node_disk_io_time_seconds:rate5m",
      expression = "rate(node_disk_io_time_seconds_total{job=\"node\", device!=\"\"}[5m])"
    },
    {
      enabled    = true,
      record     = "instance_device:node_disk_io_time_weighted_seconds:rate5m",
      expression = "rate(node_disk_io_time_weighted_seconds_total{job=\"node\", device!=\"\"}[5m])"
    },
    {
      enabled    = true,
      record     = "instance:node_network_receive_bytes_excluding_lo:rate5m",
      expression = "sum without (device) (rate(node_network_receive_bytes_total{job=\"node\", device!=\"lo\"}[5m]))"
    },
    {
      enabled    = true,
      record     = "instance:node_network_transmit_bytes_excluding_lo:rate5m",
      expression = "sum without (device) (rate(node_network_transmit_bytes_total{job=\"node\", device!=\"lo\"}[5m]))"
    },
    {
      enabled    = true,
      record     = "instance:node_network_receive_drop_excluding_lo:rate5m",
      expression = "sum without (device) (rate(node_network_receive_drop_total{job=\"node\", device!=\"lo\"}[5m]))"
    },
    {
      enabled    = true,
      record     = "instance:node_network_transmit_drop_excluding_lo:rate5m",
      expression = "sum without (device) (rate(node_network_transmit_drop_total{job=\"node\", device!=\"lo\"}[5m]))"
    }
  ]
}



module "grafana" {
  source                      = "./modules/grafana"
  grafana_name                = "myGrafanaDashboard"
  resource_group_name         = module.resource_group.name
  grafana_location            = var.location
  azure_monitor_workspace_id  = module.monitor_workspace.workspace_id
}

#module "grafana_role_assignment" {
#  source                      = "./modules/role_assignment"
#  scope                       = module.monitor_workspace.workspace_id
#  role_definition_name_or_id  = "Monitoring Reader"
#  principal_id                = module.grafana.principal_id 
#}

#module "grafana_role_assignment_admins" {
#  source                      = "./modules/role_assignment"
#  scope                       = module.monitor_workspace.workspace_id
#  role_definition_name_or_id  = "Grafana Admin"
#  principal_id                = "592ce1c9-046b-45a7-ae5f-07b565cec71c"
#}




