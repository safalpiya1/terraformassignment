locals {
  tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "Safal.Piya"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}


module "rgroup-n01526950" {
  source   = "./modules/rgroup-n01526950"
  rg_name = "n01526950-RG"
  location = "Canada Central" 
  tags = local.tags 
}

module "network-n01526950" {
  source       = "./modules/network"
  location     = module.rgroup-n01526950.resource_group.location
  resource_group_name =  module.rgroup-n01526950.resource_group.name
  virtual_network_name = "n01526950-VNET"
  address_space        = ["10.0.0.0/16"]
  subnet_name         = "n01526950-SUBNET"
  subnet_address_prefixes = ["10.0.0.0/24"]
  nsg_name            = "n01526950-NSG"
  tags = local.tags 

}


module "common_services" {
  source             = "./modules/common-n01526950"
  location     = module.rgroup-n01526950.resource_group.location
  resource_group_name =  module.rgroup-n01526950.resource_group.name
  workspace_name = "n01526950-WORKSPACE"
  recovery_vault_name = "n01526950-RECOVERYVAULT"
  storage_account_name = "no1526950storage"
  tags = local.tags 
}

module "vmlinux-n01526950" {
  source                = "./modules/vmlinux-n01526950"
  location     = module.rgroup-n01526950.resource_group.location
  resource_group_name =  module.rgroup-n01526950.resource_group.name
  subnet_id           = module.network-n01526950.subnet.id
  linux_avs = "n01526950-AVS"
  tags = local.tags 

}


module "vmwindows-n01526950" {
  source              = "./modules/vmwindows-n01526950"
  windows_avs = "windowsAvailabilitySet"
  location     = module.rgroup-n01526950.resource_group.location
  resource_group_name =  module.rgroup-n01526950.resource_group.name
  subnet_id           = module.network-n01526950.subnet.id
  nb_count =  1
  tags = local.tags

}


module "datadisk-n01526950" {
  source              = "./modules/datadisk-n01526950"
  linux_vm_ids        = values(module.vmlinux-n01526950.vm_ids)
  windows_vm_id       = module.vmwindows-n01526950.vm_ids
  resource_group_name =  module.rgroup-n01526950.resource_group.name
  location     = module.rgroup-n01526950.resource_group.location
  linux-vms = module.vmlinux-n01526950.vm_hostnames
  windows-vms = module.vmwindows-n01526950.vm_hostname_windows
  tags = local.tags

}

module "loadbalancer-n01526950" {
  source                = "./modules/loadbalancer-n01526950"
  location              = module.rgroup-n01526950.resource_group.location
  resource_group_name   = module.rgroup-n01526950.resource_group.name
  loadbalancer-name     = "n01526950-LOADBALANCER"
  linux-nic-id          = module.vmlinux-n01526950.nic_ids
  tags                  = local.tags
  linux-vm-name   = module.vmlinux-n01526950.vm_hostnames

  
}
module "database-n01526950" {
  source      = "./modules/database-n01526950"
 location              = module.rgroup-n01526950.resource_group.location
  resource_group_name   = module.rgroup-n01526950.resource_group.name
  db_name = "n01526950-DATABASE"
  tags = local.tags
}

