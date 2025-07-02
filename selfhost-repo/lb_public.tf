
resource "azurerm_lb" "public_lb" {
  name                = var.public-lb
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"
  frontend_ip_configuration {
    name                 = "public-lb-fe"
    public_ip_address_id = azurerm_public_ip.lb-public.id
  }
}
