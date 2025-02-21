# Outputs
output "resource_group_name" {
  description = "The name of the resource group."
  value       = module.resource_group.resource_group_name
}

output "vnet_name" {
  description = "The name of the Virtual Network."
  value       = module.vnet.vnet_name
}

output "subnet_name" {
  description = "The name of the Subnet."
  value       = keys(module.vnet.subnet_ids) # Output all subnet names
}

output "cluster_name" {
  description = "The name of the AKS cluster."
  value       = module.aks.cluster_name
}

output "kube_config" {
  description = "The kubeconfig file content for accessing the AKS cluster."
  value       = module.aks.kube_config
  sensitive   = true
}

output "cluster_fqdn" {
  description = "The FQDN of the AKS cluster."
  value       = module.aks.cluster_fqdn
}
