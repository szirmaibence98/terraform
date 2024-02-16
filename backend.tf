

terraform {
  version = "~> 2.30"  
  backend "azurerm" {
    resource_group_name   = "terraform"
    storage_account_name  = "terraformszirmaidaimler"
    container_name        = "statefiles"
#    key                   = "terraform.tfstate"
  }
}