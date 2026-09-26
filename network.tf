resource "azurerm_virtual_network" "stage7" {
  name                = "Stage7VNet"
  location            = azurerm_resource_group.stage7.location
  resource_group_name = azurerm_resource_group.stage7.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "stage7" {
  name                 = "Stage7Subnet"
  resource_group_name  = azurerm_resource_group.stage7.name
  virtual_network_name = azurerm_virtual_network.stage7.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_security_group" "stage7" {
  name                = "Stage7NSG"
  location            = azurerm_resource_group.stage7.location
  resource_group_name = azurerm_resource_group.stage7.name

  security_rule {
    name                       = "AllowSSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix     = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowStreamlit"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8501"
    source_address_prefix     = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_public_ip" "stage7" {
  name                = "Stage7PublicIP"
  location            = azurerm_resource_group.stage7.location
  resource_group_name = azurerm_resource_group.stage7.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_interface" "stage7" {
  name                = "Stage7NIC"
  location            = azurerm_resource_group.stage7.location
  resource_group_name = azurerm_resource_group.stage7.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.stage7.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.stage7.id
  }
}

resource "azurerm_network_interface_security_group_association" "stage7" {
  network_interface_id      = azurerm_network_interface.stage7.id
  network_security_group_id = azurerm_network_security_group.stage7.id
}
