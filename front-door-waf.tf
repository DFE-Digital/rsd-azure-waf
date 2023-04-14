module "azurerm_front_door_waf" {
  source = "github.com/DFE-Digital/terraform-azurerm-front-door-waf?ref=v0.1.0"

  environment    = local.environment
  project_name   = local.project_name
  azure_location = local.azure_location

  cdn_sku              = local.cdn_sku
  cdn_response_timeout = local.cdn_response_timeout

  cdn_waf_targets = local.cdn_waf_targets

  enable_waf                            = local.enable_waf
  waf_mode                              = local.waf_mode
  waf_enable_rate_limiting              = local.waf_enable_rate_limiting
  waf_rate_limiting_duration_in_minutes = local.waf_rate_limiting_duration_in_minutes
  waf_rate_limiting_threshold           = local.waf_rate_limiting_threshold
  waf_rate_limiting_bypass_ip_list      = local.waf_rate_limiting_bypass_ip_list
  waf_managed_rulesets                  = local.waf_managed_rulesets
  waf_custom_rules                      = local.waf_custom_rules

  tags = local.tags
}
