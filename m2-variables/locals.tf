locals {
  base_name  = "${var.prefix}-${var.env}"
  vnet_cidr  = var.env == "prod" ? ["10.10.0.0/16"] : ["10.0.0.0/16"]
  subnet_net = var.env == "prod" ? ["10.10.1.0/24"] : ["10.0.1.0/24"]
}