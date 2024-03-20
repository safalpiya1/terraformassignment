resource "azurerm_availability_set" "linux_availability_set" {
  name                = var.linux_avs
  resource_group_name = var.resource_group_name
  location            = var.location
  tags = var.tags

  platform_fault_domain_count  = 2
  platform_update_domain_count = 5
}

resource "azurerm_network_interface" "linux_nic" {
  for_each = var.linux_vm_names
  name = "${each.value}-nic"
  location             = var.location
  resource_group_name  = var.resource_group_name

  ip_configuration {
    name                          = "${each.value}-ipconfig"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip[each.key].id
    subnet_id                     = var.subnet_id
  }
  tags = var.tags
}

resource "azurerm_public_ip" "pip" {
  for_each = var.linux_vm_names
  name                = "${each.value}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
  domain_name_label   = "${each.value}"
  tags = var.tags
  
}

resource "azurerm_linux_virtual_machine" "linux_vm" {
  for_each = var.linux_vm_names
  name                            = "${each.value}"
  resource_group_name             = var.resource_group_name
  location                        = var.location
  size                            = var.size
  admin_username                  = var.admin_username
  disable_password_authentication = true

  availability_set_id = azurerm_availability_set.linux_availability_set.id

  network_interface_ids           = [azurerm_network_interface.linux_nic[each.key].id]
  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.public_key)
  }
  os_disk {
    name                 = "${each.value}-os-disk"
    caching              = var.os_disk_caching
    storage_account_type = var.os_disk_storage_account_type
    disk_size_gb         = var.os_disk_size
  }
  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = var.CentOS_version
  }
  tags = var.tags
  
}

resource "azurerm_virtual_machine_extension" "network_watcher_extension" {
  for_each = azurerm_linux_virtual_machine.linux_vm

  name                 = "${each.value.name}-network-watcher-extension"
  virtual_machine_id   = each.value.id
  publisher            = "Microsoft.Azure.NetworkWatcher"
  type                 = "NetworkWatcherAgentLinux"
  type_handler_version = var.network_watcher_extension_version
  tags = var.tags
}

resource "azurerm_virtual_machine_extension" "azure_monitor_extension" {
  for_each = azurerm_linux_virtual_machine.linux_vm

  name                 = "${each.value.name}-azure-monitor-extension"
  virtual_machine_id   = each.value.id
  publisher            = "Microsoft.Azure.Monitor"
  type                 = "AzureMonitorLinuxAgent"
  type_handler_version = var.azure_monitor_extension_version
  tags = var.tags
}


