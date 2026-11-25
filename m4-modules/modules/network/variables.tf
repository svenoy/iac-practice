# This constitutes the input interface for the network module. It defines the variables 
# that can be passed to the module from the calling (invoking) module.
variable "name_prefix" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "vnet_cidr" {
  type = string
}

variable "subnet_cidr" {
  type = string
}
