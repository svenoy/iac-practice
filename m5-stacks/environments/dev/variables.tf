# These are the top-level variables for the dev environment. They will be passed to the 
# child modules, which will use them to create resources. The child modules will then 
# pass values back to the intermediary module, which will pass them here to the top module.
# Thus, this top module will be the source of truth for these values.

variable "env" {
  type = string
}

variable "project" {
  type = string
}

variable "location" {
  type = string
}

variable "vnet_cidr" {
  type = string
}

variable "subnet_cidr" {
  type = string
}
