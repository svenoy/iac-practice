output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "subnet_prefix" {
  value     = azurerm_subnet.snet.address_prefixes[0]
  sensitive = true
}