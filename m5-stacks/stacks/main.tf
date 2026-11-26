# This intermediary module groups related components (Resource Group and Network) into one repeatable architecture.
# It channels input variables down as arguments to child modules and passes child output attributes upward.
# By keeping environment-specific values out of this layer, the same architecture stays consistent for dev and prod.
# (Like Tier 1, this is still a child module with no state file of its own.
# Its outputs.tf forwards selected child attributes back up to the root stack.)

locals {
  name_prefix = "${var.project}-${var.env}"
}

resource "azurerm_resource_group" "this" {
  name     = "rg-${local.name_prefix}"
  location = var.location
}

module "network" {
  source              = "../../modules/network"
  prefix              = local.name_prefix
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
  vnet_cidr           = var.vnet_cidr
  subnet_cidr         = var.subnet_cidr
}
