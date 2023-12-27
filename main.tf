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