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
      name             = "subnet1"
      address_prefixes = ["10.0.1.0/24"]
      nsg_id           = module.nsg.nsg_id
    },
    {
      name             = "subnet2"
      address_prefixes = ["10.0.2.0/24"]
      nsg_id           = null // Explicitly set to null if needed
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
  subnet_id             = module.subnets.subnet_ids["subnet1"]
  network_interface_name = "myLinuxVMNic"
  tags                  = {
    Environment = var.environment
  }
}

module "linux_vm" {
  source = "./modules/linux_vm"
  
  resource_group_name    = module.resource_group.name
  location               = var.location
  vm_name                = "myLinuxVM"
  vm_size                = "Standard_B1ls"
  admin_username         = "adminuser"
  admin_password         = "SecurePassword123!"
  network_interface_id   = module.network_interface.id
  
  log_analytics_workspace_id = module.log_analytics_workspace.workspace_resource_id
}


module "vm_logging" {
  source                      = "./modules/monitor_diagnostic_setting"
  target_resource_id          = module.linux_vm.vm_id
  log_analytics_workspace_id  = module.log_analytics_workspace.workspace_id
  logs_to_enable              = [
    { category = "AuditLogs", enabled = true },
    { category = "SignInLogs", enabled = true }
  ]
  metrics_to_enable           = [
    { category = "AllMetrics", enabled = true }
  ]
}
