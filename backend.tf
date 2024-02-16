terraform {
  required_version = ">= 0.12"  // Adjust this as necessary for your Terraform CLI version requirement

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.30"  // Correct way to specify the AzureRM provider version
    }
  }

  backend "azurerm" {
    resource_group_name  = "terraform"
    storage_account_name = "terraformszirmaidaimler"
    container_name       = "statefiles"
#    key                  = "terraform.tfstate"  // Uncomment or adjust as necessary
  }
}
