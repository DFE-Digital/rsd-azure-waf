terraform {
  required_version = "~> 1.9"

  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}
