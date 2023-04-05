locals {
  environment    = var.environment
  project_name   = var.project_name
  azure_location = var.azure_location

  sku                     = var.sku
  enable_latency_monitor  = var.enable_latency_monitor
  monitor_action_group_id = var.monitor_action_group_id
  response_timeout        = var.response_timeout

  # Populate the Resource Group IDs
  container_app_origin_group_with_resource_ids = { for name, options in var.container_app_origins : name => {
    name : options.name
    origin_group_name : options.origin_group_name
    resource_group_id : data.azurerm_resource_group.container_apps[name].id
  } }

  # Grab the Container App FQDN
  container_app_origin_group = { for name, options in local.container_app_origin_group_with_resource_ids : options.origin_group_name => jsondecode(data.azapi_resource.container_apps[name].output).properties.configuration.ingress.fqdn }

  # Override the Origin hostnames with the Container App hostnames
  origin_groups = { for name, origin_group in var.origin_groups : name => {
    origins : length(origin_group.origins) == 0 ? try(local.container_app_origin_group[name] != "", false) ? [local.container_app_origin_group[name]] : [] : origin_group.origins
    domains : origin_group.domains
    enable_health_probe : origin_group.enable_health_probe
    health_probe_interval : origin_group.health_probe_interval
    health_probe_request_type : origin_group.health_probe_request_type
    health_probe_path : origin_group.health_probe_path
  } }

  enable_waf                            = var.enable_waf
  waf_enable_rate_limiting              = var.waf_enable_rate_limiting
  waf_rate_limiting_duration_in_minutes = var.waf_rate_limiting_duration_in_minutes
  waf_rate_limiting_threshold           = var.waf_rate_limiting_threshold
  waf_rate_limiting_bypass_ip_list      = var.waf_rate_limiting_bypass_ip_list
  waf_managed_rulesets                  = var.waf_managed_rulesets

  tags = var.tags
}