module "azurerm_front_door_waf" {
  source = "github.com/DFE-Digital/terraform-azurerm-front-door-waf"

  environment         = local.environment
  project_name        = local.project_name
  resource_group_name = local.resource_group_name
  azure_location      = local.azure_location
  tags                = local.tags
}
