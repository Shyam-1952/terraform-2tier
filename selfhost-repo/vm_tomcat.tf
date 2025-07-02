
resource "azurerm_linux_virtual_machine" "tomcat_vm" {
  name                = var.tomcat-vm
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.app_nic.id]
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
sudo su
apt update 
apt install openjdk-11-jdk -y
apt-cache search tomcat
apt install tomcat9 tomcat9-admin -y
ufw allow from any to any port 8080 proto tcp
EOF
  )
}
