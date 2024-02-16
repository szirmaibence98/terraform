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
      nsg_id           = module.nsg.nsg_id // Associate NSG with subnet1
    },
    {
      name             = "subnet2"
      address_prefixes = ["10.0.2.0/24"]
      // Optionally, include nsg_id here if you have a different NSG for subnet2 or leave it out if no NSG is needed
    }
  ]
}


module "nsg" {
  source              = "./modules/nsg"
  nsg_name            = "myCustomNSG"
  location            = var.location
  resource_group_name = azurerm_resource_group.example.name
  security_rules      = [
    {
      name                       = "allow-http"
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
      name                       = "allow-https"
      priority                   = 110
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
    Environment = "Production"
  }
}




module "network_watcher" {
  source              = "./modules/network_watcher"
  network_watcher_name = "customNetworkWatcherName"
  location            = var.location
  resource_group_name = module.resource_group.name
}


module "nsg_flow_logs" {
  source               = "./modules/nsg_flow_logs"
  network_watcher_name = module.network_watcher.network_watcher.name
  resource_group_name  = module.resource_group.name
  storage_account_id   = azurerm_storage_account.example.id
  nsg_ids              = [azurerm_network_security_group.example.id]
}
