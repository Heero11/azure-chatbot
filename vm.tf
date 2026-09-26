resource "azurerm_linux_virtual_machine" "stage7" {
  name                = "Stage7VM"
  resource_group_name = azurerm_resource_group.stage7.name
  location            = azurerm_resource_group.stage7.location
  size                = "Standard_D2ads_v7"

  admin_username = "azureuser"

  network_interface_ids = [
    azurerm_network_interface.stage7.id
  ]

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
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }

  identity {
    type = "SystemAssigned"
  }
}
