output "virtual_network_name" {
  value = azurerm_virtual_network.virtual_network.name
}

output "subnet" {
  value = azurerm_subnet.subnet
}

output "nsg_name" {
  value = azurerm_network_security_group.nsg.name
}