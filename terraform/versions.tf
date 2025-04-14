terraform {
  required_version = "1.11.4"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.26.0"
    }
  }
}


provider "azurerm" {
  # Configuration options
  subscription_id = "0dbe38b1-8aaf-4701-839c-ff2aa2edf7c5"
  tenant_id = "0dbe38b1-8aaf-4701-839c-ff2aa2edf7c5"
  features {}
}

