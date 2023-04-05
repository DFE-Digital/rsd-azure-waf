module "azurerm_front_door_waf" {
  source = "github.com/DFE-Digital/terraform-azurerm-front-door-waf?ref=v0.2.0"

  environment    = local.environment
  project_name   = local.project_name
  azure_location = local.azure_location

  sku                     = local.sku
  enable_latency_monitor  = local.enable_latency_monitor
  monitor_action_group_id = local.monitor_action_group_id
  response_timeout        = local.response_timeout

  # Origins
  origin_groups = local.origin_groups

  enable_waf                            = local.enable_waf
  waf_enable_rate_limiting              = local.waf_enable_rate_limiting
  waf_rate_limiting_duration_in_minutes = local.waf_rate_limiting_duration_in_minutes
  waf_rate_limiting_threshold           = local.waf_rate_limiting_threshold
  waf_rate_limiting_bypass_ip_list      = local.waf_rate_limiting_bypass_ip_list
  waf_enable_bot_protection             = local.waf_enable_bot_protection
  waf_enable_default_ruleset            = local.waf_enable_default_ruleset

  tags = local.tags
}
