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
  tags                = { Environment = "Development" }
}

module "subnets" {
  source               = "./modules/subnet"
  resource_group_name  = module.resource_group.name
  virtual_network_name = module.vnet.name
  subnets = [
    {
      name             = "subnet1"
      address_prefixes = ["10.0.1.0/24"]
    },
    {
      name             = "subnet2"
      address_prefixes = ["10.0.2.0/24"]
    }
  ]
}
