terraform {
  required_version = "1.11.4"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.26.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.7.1"
    }
  }
}

provider "azurerm" {
  # Configuration options
  subscription_id = ""
  tenant_id       = ""
  features {}
}

