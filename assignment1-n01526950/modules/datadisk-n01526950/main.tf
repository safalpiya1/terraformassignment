

resource "azurerm_managed_disk" "linux-managed-disk" {
  count               = length(var.linux-vms)
  name                = "linux-datadisk-${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name
  storage_account_type = "Standard_LRS"
  create_option       = "Empty"
  disk_size_gb        = 10

   tags = var.tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "linux-disk-attach" {
  count               = length(var.linux-vms)
  managed_disk_id    = azurerm_managed_disk.linux-managed-disk[count.index].id
  virtual_machine_id = var.linux_vm_ids[count.index % length(var.linux_vm_ids)]
  lun                = "0"
  caching            = "ReadWrite"

  
}


resource "azurerm_managed_disk" "windows-managed-disk" {
  count               = length(var.windows-vms)
  name                = "windows-datadisk-${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name
  storage_account_type = "Standard_LRS"
  create_option       = "Empty"
  disk_size_gb        = 10

   tags = var.tags
}


resource "azurerm_virtual_machine_data_disk_attachment" "windows-disk-attach" {
  count               = length(var.windows-vms)
  managed_disk_id     = azurerm_managed_disk.windows-managed-disk[count.index].id
  virtual_machine_id  = var.windows_vm_id[count.index % length(var.windows_vm_id)]
  lun                 = "0"
  caching             = "ReadWrite"
}
