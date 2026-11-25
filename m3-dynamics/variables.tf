variable "prefix" {
  type    = string
  default = "ss963"
}

variable "location" {
  type    = string
  default = "norwayeast"
}

variable "subnets" {
  type = map(string)
  default = {
    web = "10.0.1.0/24"
    db  = "10.0.2.0/24"
    app = "10.0.3.0/24"
  }
}

variable "nsg_rules" {
  type = list(object({
    name     = string
    priority = number
    port     = string
  }))
  default = [
    { name = "allow_ssh", priority = 100, port = "22" } # HTTP rule has been removed to illustrate dynamic NSG rule creation. We can add more rules as needed.
  ]
}

variable "deploy_vm" {
  type    = bool
  default = false
}

variable "ssh_public_key" {
  type    = string
  default = ""
}
