
data "azurerm_virtual_network" "vnet" {
  name                = local.vnet_name
  resource_group_name = local.vnet_rg
}

data "azurerm_subnet" "aks_subnet" {
  name                 = var.aks_subnet_name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_virtual_network.vnet.resource_group_name
}

data "azurerm_route_table" "rt_vnet" {
  name                = local.route_table_name
  resource_group_name = data.azurerm_virtual_network.vnet.resource_group_name
}
