# This constitutes the output interface for the network module. It defines the values that will
# be returned to the calling module's state-file after the network resources have been created.
output "subnet_id" {
  value = azurerm_subnet.this.id
}
