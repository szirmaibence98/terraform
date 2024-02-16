

terraform {
  required_version = ">= 1.4.0"    
  backend "azurerm" {
    resource_group_name   = "terraform"
    storage_account_name  = "terraformszirmaidaimler"
    container_name        = "statefiles"
#    key                   = "terraform.tfstate"
  }
}