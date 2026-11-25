# This is an intermediary module that is used to pass variables to the other modules. It is 
# not intended to be used directly. 
# The variables are defined here, primarily to avoid having to define them in each module that 
# uses them, but also to provide a single source of truth for these values. Thus, the environment
# module defines all variables and this module consistently passes them to the other modules. 

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
