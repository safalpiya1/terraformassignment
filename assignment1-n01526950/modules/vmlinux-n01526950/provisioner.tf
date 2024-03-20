resource "null_resource" "display_hostnames" {
  for_each = azurerm_linux_virtual_machine.linux_vm

  depends_on = [azurerm_linux_virtual_machine.linux_vm, azurerm_public_ip.pip]

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = var.admin_username
      private_key = file(var.private_key)
      host        = azurerm_public_ip.pip[each.key].ip_address  
    }

    inline = [
      "echo 'Hostname of VM ${azurerm_linux_virtual_machine.linux_vm[each.key].name}: $(hostname)'"
    ]
  }
}
