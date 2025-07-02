
resource "azurerm_linux_virtual_machine" "nginx_vm" {
  name                = var.nginx-vm
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.web_nic.id]
  size               = "Standard_B1s"
  admin_username     = var.admin_username
  admin_password     = var.admin_password
  disable_password_authentication = false

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

  custom_data = base64encode(<<EOF
#!/bin/bash
sudo apt update
sudo apt install nginx -y
EOF
  )
}
