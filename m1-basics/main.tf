terraform {
  required_version = ">= 1.9.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "practice" {
  name     = "rg-ss963-m1-practice"
  location = "norwayeast"
}

resource "azurerm_virtual_network" "practice" {
  name                = "vnet-ss963-m1"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.practice.location
  resource_group_name = azurerm_resource_group.practice.name
  tags = { purpose = "m1-practice" }
}

# Because azurerm_virtual_network.practice uses azurerm_resource_group.practice.name, Terraform 
# builds a dependency graph and creates the resource group first.
