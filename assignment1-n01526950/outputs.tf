output "resource_group" {
  value = module.rgroup-n01526950.resource_group.name
}

output "virtual_network_name" {
  value = module.network-n01526950.virtual_network_name
}

output "subnet" {
  value = module.network-n01526950.subnet.name
}

output "log_analytics_workspace_name" {
  value = module.common_services.log_analytics_workspace_name
}

output "recovery_vault_name" {
  value = module.common_services.recovery_vault_name
}

output "storage_account_name" {
  value = module.common_services.storage_account_name
}

output "vm_hostnames" {
  value = module.vmlinux-n01526950.vm_hostnames
}

output "vm_domain_names" {
  value = module.vmlinux-n01526950.vm_domain_names
}

output "vm_private_ip_addresses" {
  value = module.vmlinux-n01526950.vm_private_ip_addresses
}

output "vm_public_ip_addresses" {
  value = module.vmlinux-n01526950.vm_public_ip_addresses
}

output "windows_vm_hostnames" {
  value = module.vmwindows-n01526950.vm_hostname_windows
  
}

output "windows_vm_private_ip" {
  value = module.vmwindows-n01526950.private_ip_addresses_windows
}

output "windows_vm_public_ip" {
  value = module.vmwindows-n01526950.public_ip_addresses_windows
}


output "windows_vm_fqdn" {
  value = module.vmwindows-n01526950.vm_fqdn_windows
}

output "linux_vm_id" {
  value = module.vmlinux-n01526950.vm_ids
}

output "window_vm_id" {
  value = module.vmwindows-n01526950.vm_ids
}