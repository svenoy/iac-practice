# These module outputs are used to pass values from this module to the parent module. 
# The parent module can then use these values to create other resources that depend on them.
# The child modules employ these outputs to pass values back here and then to the parent module.
# This provides a convenient mechanism for passing values between modules, and provides consistency 
# and structure. (Thus, attributes are channeled through this module by the parent module.)

output "resource_group_name" {
  value = azurerm_resource_group.this.name
}

output "subnet_id" {
  value = module.network.subnet_id # Attributes are fetched from the child module outputs.
}
