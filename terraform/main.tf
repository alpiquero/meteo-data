locals {
  vm_admin_password = var.vm_admin_password != null ? var.vm_admin_password : random_password.password[0].result
}


resource "random_password" "password" {
  count            = var.vm_admin_password != null ? 0 : 1
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "azurerm_resource_group" "this" {
  name     = "meteo-data"
  location = "West Europe"
}

resource "azurerm_virtual_network" "this" {
  name                = "meteo-data"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_subnet" "this" {
  name                 = "subnet"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "this" {
  name                = "vmnet-1"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  allocation_method   = "Dynamic"

  lifecycle {
    create_before_destroy = true
  }
}

resource "azurerm_network_interface" "this" {
  name                = "vmnic-1"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  ip_configuration {
    name                          = "public"
    subnet_id                     = azurerm_subnet.this.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.this.id
  }
}

resource "azurerm_linux_virtual_machine" "this" {
  name                = "meteo-data"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  size                = "Standard_B1s"
  admin_username      = var.vm_admin_username
  admin_password      = local.vm_admin_password
  network_interface_ids = [
    azurerm_network_interface.this.id,
  ]

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

  user_data = filebase64("${path.module}/files/cloudinit.yaml")
}

resource "azurerm_network_security_group" "this" {
  name                = "nsg-vm-subnet"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  security_rule {
    name                   = "Allow_SSH"
    access                 = "Allow"
    priority               = 500
    protocol               = "Tcp"
    direction              = "Inbound"
    description            = "Allow SSH inbound"
    source_port_range      = "*"
    destination_port_range = "22"
  }

  security_rule {
    name                   = "Allow_Grafana"
    access                 = "Allow"
    priority               = 550
    protocol               = "Tcp"
    direction              = "Inbound"
    description            = "Allow Grafana inbound"
    source_port_range      = "*"
    destination_port_range = "3000"
  }

  security_rule {
    name                   = "Allow_All_Outbound"
    access                 = "Allow"
    priority               = 900
    protocol               = "*"
    direction              = "Outbound"
    description            = "Allow all outbound traffic"
    source_port_range      = "*"
    destination_port_range = "*"
  }
  security_rule {
    name                   = "Deny_All_Inbound"
    access                 = "Deny"
    priority               = 1000
    protocol               = "*"
    direction              = "Inbound"
    description            = "Deny all inbound traffic"
    source_port_range      = "*"
    destination_port_range = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "this" {
  network_security_group_id = azurerm_network_security_group.this.id
  subnet_id                 = azurerm_subnet.this.id
}

