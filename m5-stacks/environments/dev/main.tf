# This thin entry point is where you run Terraform CLI commands and state is stored. It configures
# one specific instance by feeding concrete values (from dev.tfvars) into the stack module's input arguments.
# Encapsulation hides the internal VNet and Subnet details, exposing only what the stack chooses to output.
# (As this root dir owns the terraform.tfstate file, this isolates dev infrastructure from other environments.
# Only values exported by this layer's outputs.tf appear in CLI output and root state.)

module "app_stack" {
  source      = "../../stacks"
  env         = var.env
  project     = var.project
  location    = var.location
  vnet_cidr   = var.vnet_cidr
  subnet_cidr = var.subnet_cidr
}
