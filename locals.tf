locals {
  environment    = var.environment
  project_name   = var.project_name
  azure_location = var.azure_location

  sku                       = var.sku
  enable_latency_monitor    = var.enable_latency_monitor
  monitor_action_group_id   = var.monitor_action_group_id
  response_timeout          = var.response_timeout
  key_vault_allow_ipv4_list = var.key_vault_allow_ipv4_list
  key_vault_access_users    = var.key_vault_access_users

  origin_groups = var.origin_groups

  certificates = { for i, c in var.certificates : i => { password : c.password, contents : filebase64(abspath(c.contents)) } }

  enable_waf                            = var.enable_waf
  waf_enable_rate_limiting              = var.waf_enable_rate_limiting
  waf_rate_limiting_duration_in_minutes = var.waf_rate_limiting_duration_in_minutes
  waf_rate_limiting_threshold           = var.waf_rate_limiting_threshold
  waf_rate_limiting_bypass_ip_list      = var.waf_rate_limiting_bypass_ip_list
  waf_enable_bot_protection             = var.waf_enable_bot_protection
  waf_enable_default_ruleset            = var.waf_enable_default_ruleset

  tags = var.tags
}