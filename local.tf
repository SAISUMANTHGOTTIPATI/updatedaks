locals {
  application_name = "ifmco"
  location         = "uksouth"
  resource_prefix  = "ggbre-${local.application_name}-${var.environment}-"

  main_resource_group_name   = "${local.application_name}-main-emea-${var.environment}-rg"
  shared_resource_group_name = "${local.application_name}-shared-emea-${var.environment}-rg"

  dns_rg    = "dns-main-rg"
  vnet_name = "gallagherre-emea-${var.environment}-vnet"
  log_analytics_workspace_name = "gallagherre-emea-${var.environment}-law"
  vnet_rg   = "network-rg"
  route_table_name = "rt-gallagherre-emea-${var.environment}-vnet"

  k8s_dns_prefix = "${local.application_name}-${var.environment}-k8s"

  devops_team_object_id = "8c2c73e2-9023-4972-9335-ba42c636de5b"

  tags = {
    bu                = "960604"
    app_name          = upper(local.application_name)
    environment       = title(var.environment)
    department        = "GallagherRe"
    app_group         = local.application_name
    division          = "GGBRe"
    application_name  = local.application_name
    application_owner = "charlotte_mullan@gallagherre.com"
    domain            = "emea.ajgco.com"
    techowner         = "charlotte_mullan@gallagherre.com"
  }
}
