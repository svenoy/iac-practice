output "subscription_id" {
  value = data.azurerm_client_config.current.subscription_id
}

output "subnet_ids" {
  value = { for key, subnet in azurerm_subnet.snet : key => subnet.id }
}

output "vm_public_ip" {
  value = var.deploy_vm ? azurerm_public_ip.pip[0].ip_address : "VM not deployed"
}
