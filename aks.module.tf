resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = var.cluster_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name           = "default"
    node_count     = var.node_count
    vm_size        = var.vm_size
    vnet_subnet_id = var.subnet_id # Subnet ID passed from the root module
  }

  network_profile {
    network_plugin     = "azure"
    service_cidr       = "10.1.0.0/16" # Service CIDR (non-overlapping with VNet)
    dns_service_ip     = "10.1.0.10"   # Must be within the Service CIDR
    docker_bridge_cidr = "172.17.0.1/16"
    outbound_type      = var.enable_private_cluster ? "userDefinedRouting" : "loadBalancer"
  }

  identity {
    type = "SystemAssigned"
  }

  private_cluster_enabled = var.enable_private_cluster

  tags = var.tags
}
