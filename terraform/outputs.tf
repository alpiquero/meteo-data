output "azure_resource_group_name" {
  value       = azurerm_resource_group.this.name
  description = "The name of the resource group"
}

output "virtual_machine_name" {
  value       = azurerm_linux_virtual_machine.this.name
  description = "The name of the virtual machine"
}

output "virtual_machine_public_ip" {
  value       = azurerm_public_ip.this.ip_address
  description = "The public IP address attached to the virtual machine"
}

output "virtual_machine_admin_username" {
  value       = azurerm_linux_virtual_machine.this.admin_username
  description = "The admin username of the virtual machine"
  sensitive   = true
}

output "virtual_machine_admin_password" {
  value       = azurerm_linux_virtual_machine.this.admin_password
  description = "The admin password of the virtual machine"
  sensitive   = true
}
