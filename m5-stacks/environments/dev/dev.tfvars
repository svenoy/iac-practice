# The central values for the dev environment are defined here. These values will be passed to the
# stack module below, which will handle the creation of resources. (The stack module will then 
# return output values here, which can be used by other modules or resources that depend on them.)

env         = "dev"
project     = "ss963"
location    = "norwayeast"
vnet_cidr   = "10.10.0.0/16"
subnet_cidr = "10.10.1.0/24"