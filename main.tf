
provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  
  }
}




terraform {
  required_version = ">= 1.4.0"    
  backend "azurerm" {
  }  
}
