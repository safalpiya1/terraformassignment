resource "azurerm_public_ip" "lb_public_ip" {
  name                       = "loadbalancer-pip"
  location                   = var.location
  resource_group_name        = var.resource_group_name
  allocation_method          = "Static"
  tags = var.tags
}

resource "azurerm_lb" "loadbalancer" {
  name                     = var.loadbalancer-name
  location                 = var.location
  resource_group_name      = var.resource_group_name
  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.lb_public_ip.id
  }
   tags = var.tags
}

resource "azurerm_lb_backend_address_pool" "lb_address_pool" {
  loadbalancer_id = azurerm_lb.loadbalancer.id
  name            = "BackEndAddressPool"
}

resource "azurerm_network_interface_backend_address_pool_association" "backend_pool_assoc" {
  count                  = length(var.linux-vm-name)

  network_interface_id   = var.linux-nic-id[count.index]
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb_address_pool.id
  
  ip_configuration_name = "n01526950-cs-vm${count.index + 1}-ipconfig"
}




resource "azurerm_lb_rule" "lb_rule" {
  loadbalancer_id                = azurerm_lb.loadbalancer.id  
  name                           = "Rule1"
  protocol                       = "Tcp"
  frontend_port                 = 22
  backend_port                   = 22
  frontend_ip_configuration_name = "PublicIPAddress"
}

resource "azurerm_lb_probe" "lb_probe" {
  loadbalancer_id = azurerm_lb.loadbalancer.id
  name            = "ssh-running-probe"
  port            = 22
}
