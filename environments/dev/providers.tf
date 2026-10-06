terraform {
  required_version = ">= 1.6.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "5.8.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "FinOps-RG"
    storage_account_name = "finops5636819"
    container_name       = "finops"
    key                  = "finops.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id = "f8b20355-0a02-41a3-8329-10cbc9dcdbb4"
}
