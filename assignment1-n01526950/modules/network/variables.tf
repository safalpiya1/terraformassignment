variable "location" {
  description = "The Azure region where the resources will be created"
  type        = string
}

variable "virtual_network_name" {
  description = "The name of the virtual network"
  type        = string
}

variable "resource_group_name" {
    description = "name of the resource group"
  
}
variable "subnet_name" {
  description = "name of the subnet"
  type        = string
}

variable "address_space" {
  description = "Address space for the virtual network"
}

variable "subnet_address_prefixes" {
  description = "Address prefixes for the subnet"
}

variable "nsg_name" {
  description = "Name of network security group"
}

variable "tags" {
  
}