terraform {
  required_version = ">= 1.4.4"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.51.0"
    }
    azapi = {
      source  = "Azure/azapi"
      version = ">= 1.1.0"
    }
  }
}
