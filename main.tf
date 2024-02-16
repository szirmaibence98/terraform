

module "vnet" {
  source              = "./vnet_module"
  name                = "myVNet"
  address_space       = ["10.0.0.0/16"]
  location            = "East US"
  resource_group_name = "myResourceGroup"
  tags                = { Environment = "Development" }
}

module "subnets" {
  source              = "./subnet_module"
  resource_group_name = "myResourceGroup"
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
