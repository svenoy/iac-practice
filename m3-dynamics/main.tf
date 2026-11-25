# 1. Data source: reads current Azure context without creating anything
data "azurerm_client_config" "current" {}

# 2. Resource Group with lifecycle protection against external tag edits
resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-m3-rg"
  location = var.location

  lifecycle {
    ignore_changes = [tags]
  }
}

# 3. Virtual Network (implicit dependency on RG)
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.prefix}-m3-vnet"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
}

# 4. Keyed Subnets using for_each
resource "azurerm_subnet" "snet" {
  for_each             = var.subnets
  name                 = "${var.prefix}-snet-${each.key}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [each.value]
}

# 5. NSG with dynamic nested security_rule blocks
resource "azurerm_network_security_group" "nsg" {
  name                = "${var.prefix}-m3-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  dynamic "security_rule" {
    for_each = var.nsg_rules
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = security_rule.value.port
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
}

# 6. Dedicated association resource linking NSG to every subnet
resource "azurerm_subnet_network_security_group_association" "snet_nsg" {
  for_each                  = azurerm_subnet.snet
  subnet_id                 = each.value.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# 7. Conditional VM resources (count = 1 if deploy_vm is true)
resource "azurerm_public_ip" "pip" {
  count               = var.deploy_vm ? 1 : 0 # count (a meta-argument) is applicable to all resources. (Allows us to conditionally create the public IP only when VM is deployed.)
  name                = "${var.prefix}-m3-pip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "nic" {
  count               = var.deploy_vm ? 1 : 0
  name                = "${var.prefix}-m3-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.snet["web"].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip[0].id
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  count                 = var.deploy_vm ? 1 : 0
  name                  = "${var.prefix}-m3-vm"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  size                  = "Standard_B1s"
  admin_username        = "azureuser"
  network_interface_ids = [azurerm_network_interface.nic[0].id]

  admin_ssh_key {
    username   = "azureuser"
    public_key = var.ssh_public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
