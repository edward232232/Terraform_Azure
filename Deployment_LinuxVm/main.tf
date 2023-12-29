terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "mtc-rg1" {
  name     = "my-resourcegroup"
  location = "East Us"
  tags = {
    enviroment = "dev"
  }
}

resource "azurerm_virtual_network" "mtc-vn1" {
  name                = "mtc-network"
  resource_group_name = azurerm_resource_group.mtc-rg1.name
  location            = azurerm_resource_group.mtc-rg1.location
  address_space       = ["10.123.0.0/16"]

  tags = {
    enviroment = "dev"
  }
}

resource "azurerm_subnet" "mtc-subet1" {
  name                 = "mtu-subnet"
  resource_group_name  = azurerm_resource_group.mtc-rg1.name
  virtual_network_name = azurerm_virtual_network.mtc-vn1.name
  address_prefixes     = ["10.123.1.0/24"]
}

resource "azurerm_network_security_group" "mtu-sg1" {
  name                = "mtc-sg"
  location            = azurerm_resource_group.mtc-rg1.location
  resource_group_name = azurerm_resource_group.mtc-rg1.name

  security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  tags = {
    enviroment = "dev"
  }


}

resource "azurerm_subnet_network_security_group_association" "mtsga" {
  subnet_id                 = azurerm_subnet.mtc-subet1.id
  network_security_group_id = azurerm_network_security_group.mtu-sg1.id
}



resource "azurerm_public_ip" "mtc-ip1" {
  name                = "mtc-ip1"
  resource_group_name = azurerm_resource_group.mtc-rg1.name
  location            = azurerm_resource_group.mtc-rg1.location
  allocation_method   = "Dynamic"

  tags = {
    environment = "dev"
  }
}

resource "azurerm_network_interface" "mtc-nic1" {
  name                = "mtc-nic"
  location            = azurerm_resource_group.mtc-rg1.location
  resource_group_name = azurerm_resource_group.mtc-rg1.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.mtc-subet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.mtc-ip1.id
  }


}

resource "azurerm_linux_virtual_machine" "mtc-vm1" {
  name                  = "mtu-vm"
  location              = azurerm_resource_group.mtc-rg1.location
  resource_group_name   = azurerm_resource_group.mtc-rg1.name
  size                  = "Standard_B1s"
  admin_username        = "adminuser"
  network_interface_ids = [azurerm_network_interface.mtc-nic1.id]

  custom_data = filebase64("customdata.tpl")

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/azuretfkey.pub")
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  provisioner "local-exec" {
    command = templatefile("${var.host_os}-ssh.tpl", {
      hostname     = self.public_ip_address,
      user         = "adminuser",
      identityfile = "~/.ssh/azuretfkey"
    })
    interpreter = var.host_os == "windows" ? ["Powershell", "-Command"] : ["/bin/bash", "-c"]
  }
  tags = {
    environment = "dev"
  }
}

data "azurerm_public_ip" "mtc-ip-data" {
  name                = azurerm_public_ip.mtc-ip1.name
  resource_group_name = azurerm_resource_group.mtc-rg1.name
}


output "public_ip_address" {
  value = "${azurerm_linux_virtual_machine.mtc-vm1.name} ${data.azurerm_public_ip.mtc-ip-data.ip_address}"
}