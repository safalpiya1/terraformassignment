resource "azurerm_availability_set" "windows_avs" {
  name                = var.windows_avs
  resource_group_name = var.resource_group_name
  location            = var.location
  platform_fault_domain_count = 2
  platform_update_domain_count = 5
  tags = var.tags
}

resource "azurerm_windows_virtual_machine" "windows_vm" {
  count = var.nb_count
  name = "${var.windows_name}${format("%1d", count.index+1)}"
  resource_group_name = var.resource_group_name
  location            = var.location
  availability_set_id  = azurerm_availability_set.windows_avs.id
  network_interface_ids = [azurerm_network_interface.network_interface_windows[count.index].id]

  admin_username = var.admin_username_windows
  admin_password = "Pass@12345!"

  size = var.size
  
  source_image_reference {
    publisher = var.windows_publisher
    offer     = var.windows_offer
    sku       = var.windows_sku
    version   = var.windows_version
  }

  os_disk {
    name              = "${var.windows_name}${format("%1d", count.index+1)}-osdisk"
    caching           = var.windows_caching
    storage_account_type = var.windows_storage_account
  }

  winrm_listener {
    protocol = "Http"
  }

  computer_name = "${var.windows_name}${format("%1d", count.index+1)}"

  tags = var.tags

}

resource "azurerm_network_interface" "network_interface_windows" {
  count = var.nb_count
  name                 = "${var.windows_name}${format("%1d", count.index+1)}-nic" 
  resource_group_name = var.resource_group_name
  location            = var.location
  ip_configuration {
    name                          = "${var.windows_name}${format("%1d", count.index+1)}-ipconfig"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = element(azurerm_public_ip.public_ip_windows[*].id, count.index+1)
  }

  tags = var.tags
}

resource "azurerm_public_ip" "public_ip_windows" {
  count = var.nb_count
  name                 = "${var.windows_name}${format("%1d", count.index+1)}-pip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method    = "Dynamic"
  domain_name_label    = "${var.windows_name}${format("%1d", count.index+1)}"

  tags = var.tags
  
}

resource "azurerm_virtual_machine_extension" "antimalware_extension" {
  count               = var.nb_count
  name                = "${var.windows_name}${format("%1d", count.index+1)}-antimalware-extension"
  virtual_machine_id  = azurerm_windows_virtual_machine.windows_vm[count.index].id  # Add index here
  publisher           = "Microsoft.Azure.Security"
  type                = "IaaSAntimalware"
  type_handler_version = "1.5"

  settings = <<SETTINGS
    {
      "AntimalwareEnabled": true
    }
SETTINGS

tags = var.tags
}
