
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.ipaddress
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}
