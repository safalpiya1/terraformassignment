output "vm_hostname_windows" {
  value = [for idx, vm in azurerm_windows_virtual_machine.windows_vm : vm.name]
}

output "private_ip_addresses_windows" {
  value = [for idx, nic in azurerm_network_interface.network_interface_windows : nic.private_ip_address]
}

output "public_ip_addresses_windows" {
  value = [for idx, ip in azurerm_public_ip.public_ip_windows : ip.ip_address]
}

output "vm_fqdn_windows" {
  value = [for idx, ip in azurerm_public_ip.public_ip_windows : ip.fqdn]
}

output "vm_ids" {
  value = azurerm_windows_virtual_machine.windows_vm[*].id
}
