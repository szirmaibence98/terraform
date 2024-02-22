output "vm_id" {
  value = azurerm_linux_virtual_machine.example.id
}

output "vm_name" {
  value = var.vm_name
}
