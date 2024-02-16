terraform {
  required_version = ">= 1.0.8"  // Adjust this as necessary for your Terraform CLI version requirement

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.92.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "terraform"
    storage_account_name = "terraformszirmaidaimler"
    container_name       = "statefiles"
#    key                  = "terraform.tfstate"  // Uncomment or adjust as necessary
  }
}
