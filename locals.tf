locals {
  environment     = var.environment
  project_name    = var.project_name
  azure_location  = var.azure_location
  tfvars_filename = var.tfvars_filename

  sku                       = var.sku
  enable_health_probe       = var.enable_health_probe
  enable_latency_monitor    = var.enable_latency_monitor
  response_timeout          = var.response_timeout
  front_door_endpoints      = var.origins
  key_vault_allow_ipv4_list = var.key_vault_allow_ipv4_list
  key_vault_access_users    = var.key_vault_access_users

  origins        = { for o in data.azurerm_cdn_frontdoor_endpoint.origins : element(split("/", o.id), length(split("/", o.id)) - 1) => o.host_name }
  custom_domains = var.custom_domains
  certificates   = { for i, c in var.certificates : i => { password : c.password, contents : filebase64(abspath(c.contents)) } }

  enable_waf                            = var.enable_waf
  waf_enable_rate_limiting              = var.waf_enable_rate_limiting
  waf_rate_limiting_duration_in_minutes = var.waf_rate_limiting_duration_in_minutes
  waf_rate_limiting_threshold           = var.waf_rate_limiting_threshold
  waf_rate_limiting_bypass_ip_list      = var.waf_rate_limiting_bypass_ip_list
  waf_enable_bot_protection             = var.waf_enable_bot_protection
  waf_enable_default_ruleset            = var.waf_enable_default_ruleset

  tags = var.tags
}