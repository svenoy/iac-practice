# This reusable building block encapsulates low-level Azure networking resources and their naming rules.
# Callers cannot see or touch internal resources directly; they only interact through the input 
# and output interface. Values enter via variables.tf, get assigned to resource arguments here, and 
# selected resource attributes leave via outputs.tf.
# This folder has no state file and is never deployed on its own (and has no knowledge of environments).
# Its outputs.tf defines its output interface, exposing the specific resource attributes needed by callers.

resource "azurerm_virtual_network" "this" {
  name                = "vnet-${var.prefix}"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = [var.vnet_cidr]
}

resource "azurerm_subnet" "this" {
  name                 = "snet-${var.prefix}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [var.subnet_cidr]
}
