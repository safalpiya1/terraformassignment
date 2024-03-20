variable "windows_avs" {

}

variable "windows_name" {
  default = "no1526950-w-vm"

}
variable "subnet_id" {
  
}
variable "admin_username_windows" {
  default = "safal"
}

variable "windows_storage_account" {
  default = "Standard_LRS"
}


variable "size" {
    default = "Standard_DS1_v2"
  
}
variable "windows_disk_size" {
  default = 128
}

variable "windows_caching" {
  default = "ReadWrite"
}

variable "windows_publisher" {
  default = "MicrosoftWindowsServer"
}

variable "windows_offer" {
  default = "WindowsServer"
}

variable "windows_sku" {
  default = "2016-Datacenter"
}

variable "windows_version" {
  default = "latest"
}

variable "location" {
}

variable "resource_group_name" {
  
}

variable "nb_count" {
  
}

variable "tags" {
  
}