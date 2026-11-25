# These child-module outputs will be used to pass values from the child module to the 
# parent module. The parent module can then use these values to manage other resources 
# that depend on them, or pass them to the environment modules or other child modules.

output "vnet_id" {
  value = azurerm_virtual_network.this.id
}

output "subnet_id" {
  value = azurerm_subnet.this.id
}
