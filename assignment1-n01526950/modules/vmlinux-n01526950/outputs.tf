output "vm_hostnames" {
  value = { for vm_name, vm in azurerm_linux_virtual_machine.linux_vm : vm_name => vm.name }
}

output "vm_domain_names" {
  value = { for vm_name, pip in azurerm_public_ip.pip : vm_name => "${pip.domain_name_label}.${azurerm_public_ip.pip[vm_name].fqdn}" }
}

output "vm_private_ip_addresses" {
  value = { for vm_name, nic in azurerm_network_interface.linux_nic : vm_name => nic.private_ip_address }
}

#output "vm_public_ip_addresses" {
#  value = { for vm_name, pip in azurerm_public_ip.pip : vm_name => azurerm_public_ip.pip[vm_name].ip_address }
#}

output "vm_public_ip_addresses" {
  value = { 
    for vm_name, public_ip in azurerm_public_ip.pip : vm_name => public_ip.ip_address
  }
}


output "linux_availability_set_id" {
  value = azurerm_availability_set.linux_availability_set.id
}

output "vm_ids" {
  value = { for vm_name, vm in azurerm_linux_virtual_machine.linux_vm : vm_name => vm.id }
}


output "nic_ids" {
  value = values(azurerm_network_interface.linux_nic)[*].id
}


output "ip_config_names" {
  value = [for idx, name in keys(azurerm_linux_virtual_machine.linux_vm) : "${name}-ipconfig${idx + 1}"]
}


