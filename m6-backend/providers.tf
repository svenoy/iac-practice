terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.0"
    }
  }

  # Left empty on purpose. Terraform reads backend settings before variables,
  # so we supply them during 'terraform init' via -backend-config.
  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}