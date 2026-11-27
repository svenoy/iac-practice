locals {
  name_prefix = "${var.project}-m7-${var.env}"
}

resource "azurerm_resource_group" "this" {
  name     = "rg-${local.name_prefix}"
  location = var.location
}

module "network" {
  source              = "../modules/network"
  prefix              = local.name_prefix
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
  vnet_cidr           = var.vnet_cidr
  subnet_cidr         = var.subnet_cidr
}
