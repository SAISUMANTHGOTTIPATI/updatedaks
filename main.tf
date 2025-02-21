# Resource Group Module
module "tags" {
  source = "../../Developer_Experience/terraform-modules/az-tags"
  tags   = local.tags
}
module "main_rg" {
  source            = "../../Developer_Experience/terraform-modules/az-resource-groups"
  location          = local.location
  resourcegroupname = local.main_resource_group_name
  subscription_id   = var.subscription_id
  tenant_id         = var.tenant_id
  tags              = module.tags.tags
}


# Backend Configuration for Terraform State
#terraform {
#  backend "azurerm" {
#    resource_group_name  = "rgname"
 #   storage_account_name = "stgaccname"
 #   container_name       = "tfstate"
 #   key                  = "terraform.tfstate"
 # }
#}

# Virtual Network Module
module "aks_subnets" {
  source              = "../../Developer_Experience/terraform-modules/az-network"
  vnetwork_name       = local.vnet_name
  location            = local.location
  subnets             = var.subnets
  resource_group_name = local.vnet_rg
  tags                = module.tags.tags
}

resource "azurerm_subnet_route_table_association" "aks_subnets_route_tables" {
  count          = length(module.aks_subnets.subnet_ids)
  subnet_id      = module.aks_subnets.subnet_ids[count.index]
  route_table_id = data.azurerm_route_table.rt_vnet.id
}

# Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "logs" {
  name                = local.log_analytics_workspace_name
  location            = local.location
  resource_group_name = local.vnet_rg
  retention_in_days   = var.log_retention_days
  tags                = module.tags.tags
}

# AKS Module
module "aks" {
  source                     = "./modules/aks"
  resource_group_name        = local.main_resource_group_name
  resource_group_location    = local.location
  cluster_name               = var.cluster_name
  dns_prefix                 = var.dns_prefix
  node_count                 = var.node_count
  vm_size                    = var.vm_size
  subnet_id                  = module.aks_subnets.subnet_ids[0] # Use the private subnet ID
  log_analytics_workspace_id = azurerm_log_analytics_workspace.logs.id
  enable_private_cluster     = var.enable_private_cluster
  tags                       = var.tags
}
