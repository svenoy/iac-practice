# In Terraform, a module is simply a container for multiple resources that are used together. 
# A module can be used to create reusable components, improve organization, and encapsulate 
# complex logic. In this case, the network module is a child module that is invoked by a parent 
# module (main.tf) to create network resources in Azure. Its inputs and outputs are defined in 
# variables.tf and outputs.tf respectively, and constitute the interface for this child module. 
# This file in the module contains actual resource definitions.
# This child module builds the set of resources each time it is invoked.

resource "azurerm_virtual_network" "this" {
  name                = "${var.name_prefix}-vnet"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = [var.vnet_cidr]
  tags                = { managed_by = "network-module" }
}

resource "azurerm_subnet" "this" {
  name                 = "${var.name_prefix}-snet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [var.subnet_cidr] # Brackets denote a list, which is the expected type for address_prefixes. This allows for multiple CIDR blocks if needed in the future.
}
