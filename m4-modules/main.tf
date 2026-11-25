# Builds a resource group and two virtual networks with subnets in Azure using the child 
# (network) module. All arguments for the child module are passed in from the parent module 
# (this file) to the child module (network/main.tf) via module blocks.
resource "azurerm_resource_group" "rg" {
  name     = "ss963-m4-rg"
  location = "norwayeast"
}

module "net_dev" {
  source              = "./modules/network"
  name_prefix         = "ss963-dev"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  vnet_cidr           = "10.10.0.0/16"
  subnet_cidr         = "10.10.1.0/24"
}

module "net_test" {
  source              = "./modules/network"
  name_prefix         = "ss963-test"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  vnet_cidr           = "10.20.0.0/16"
  subnet_cidr         = "10.20.1.0/24"
}
