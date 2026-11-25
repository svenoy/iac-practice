# This delineates the dev enironment. This top-level module will be the source of truth 
# for this environment. It passes values to the lower-level modules, which will use them 
# to create resources. The lower-level modules will return output values here, through the 
# intermediary module.

module "app_stack" {
  source      = "../../stacks"
  env         = var.env
  project     = var.project
  location    = var.location
  vnet_cidr   = var.vnet_cidr
  subnet_cidr = var.subnet_cidr
}
