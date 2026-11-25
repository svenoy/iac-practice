# These child-module variables will be passed values from the parent module. The parent module
# will pass values to these variables; the child modules will use them to create resources. 

variable "prefix" {
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
