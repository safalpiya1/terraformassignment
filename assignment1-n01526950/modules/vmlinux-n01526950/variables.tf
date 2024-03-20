variable "resource_group_name" {
  description = "Name of the resource group"
}

variable "location" {
  description = "Location for the resources"
}

variable "linux_avs" {
  
}


variable "linux_vm_names" {
    type = map(string)
    default = {
      "vm1" = "n01526950-cs-vm1"
      "vm2" = "n01526950-cs-vm2"
      "vm3" = "n01526950-cs-vm3"
      
      
    }
}


variable "subnet_id" {

}



variable "size" {
  type    = string
  default = "Standard_DS1_v2"
}

variable "admin_username" {
  type    = string
  default = "n01526950"
}

variable "admin_password" {
  type    = string
  default = "P@$$w0rd@123!"
}

variable "public_key" {
  type    = string
  default = "/home/s/.ssh/id_rsa.pub"
}

variable "private_key" {
  type    = string
  default = "/home/s/.ssh/id_rsa"
}

variable "os_disk_storage_account_type" {
  type    = string
  default = "Standard_LRS"
}

variable "os_disk_size" {
  type    = number
  default = 32
}

variable "os_disk_caching" {
  type    = string
  default = "ReadWrite"
}

variable "publisher" {
  type    = string
  default = "OpenLogic"
}

variable "offer" {
  type    = string
  default = "CentOS"
}

variable "sku" {
  type    = string
  default = "8_2"
}

variable "CentOS_version" {
  type    = string
  default = "latest"
}

variable "network_watcher_extension_version" {
  description = "The version of the Network Watcher extension"
  default = "1.4"
}

variable "azure_monitor_extension_version" {
  description = "The version of the Azure Monitor extension"
  default = "1.29"
}

variable "tags" {
  
}