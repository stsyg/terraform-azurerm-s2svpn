terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.24.0"
    }
    azuread = {
      source = "hashicorp/azuread"
    }
  }
  required_version = ">= 1.3.2"
}

provider "azurerm" {
  features {}
}
