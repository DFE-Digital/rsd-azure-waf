locals {
  environment    = var.environment
  project_name   = var.project_name
  azure_location = var.azure_location

  tfvars_filename                                    = var.tfvars_filename
  key_vault_access_users                             = var.key_vault_access_users
  key_vault_access_ipv4                              = var.key_vault_access_ipv4
  key_vault_tfvars_enable_log_analytics_workspace    = var.key_vault_tfvars_enable_log_analytics_workspace
  key_vault_tfvars_enable_diagnostic_storage_account = var.key_vault_tfvars_enable_diagnostic_storage_account

  cdn_sku                     = var.cdn_sku
  cdn_response_timeout        = var.cdn_response_timeout
  cdn_container_app_targets   = var.cdn_container_app_targets
  cdn_web_app_service_targets = var.cdn_web_app_service_targets
  cdn_windows_web_app_service_targets = {
    for cdn_web_app_service_target_name, cdn_web_app_service_target_value in local.cdn_web_app_service_targets : cdn_web_app_service_target_name => cdn_web_app_service_target_value if cdn_web_app_service_target_value.os == "Windows"
  }
  cdn_linux_web_app_service_targets = {
    for cdn_web_app_service_target_name, cdn_web_app_service_target_value in local.cdn_web_app_service_targets : cdn_web_app_service_target_name => cdn_web_app_service_target_value if cdn_web_app_service_target_value.os == "Linux"
  }
  cdn_waf_targets = merge(
    {
      for cdn_container_app_target_name, cdn_container_app_target_value in local.cdn_container_app_targets : replace(cdn_container_app_target_name, local.environment, "") => merge(
        {
          domain = jsondecode(data.azapi_resource.container_apps[cdn_container_app_target_name].output).properties.configuration.ingress.fqdn
        },
        cdn_container_app_target_value
      )
    },
    {
      for cdn_windows_web_app_service_target_name, cdn_windows_web_app_service_target_value in local.cdn_windows_web_app_service_targets : replace(cdn_windows_web_app_service_target_name, local.environment, "") => merge(
        {
          domain = data.azurerm_windows_web_app.web_apps[cdn_windows_web_app_service_target_name].default_hostname
        },
        cdn_windows_web_app_service_target_value
      )
    },
    {
      for cdn_linux_web_app_service_target_name, cdn_linux_web_app_service_target_value in local.cdn_linux_web_app_service_targets : replace(cdn_linux_web_app_service_target_name, local.environment, "") => merge(
        {
          domain = data.azurerm_linux_web_app.web_apps[cdn_linux_web_app_service_target_name].default_hostname
        },
        cdn_linux_web_app_service_target_value
      )
    }
  )

  cdn_add_response_headers    = var.cdn_add_response_headers
  cdn_remove_response_headers = var.cdn_remove_response_headers

  enable_waf                            = var.enable_waf
  waf_mode                              = var.waf_mode
  waf_enable_rate_limiting              = var.waf_enable_rate_limiting
  waf_rate_limiting_duration_in_minutes = var.waf_rate_limiting_duration_in_minutes
  waf_rate_limiting_threshold           = var.waf_rate_limiting_threshold
  waf_rate_limiting_bypass_ip_list      = var.waf_rate_limiting_bypass_ip_list
  waf_managed_rulesets                  = var.waf_managed_rulesets
  waf_custom_rules                      = var.waf_custom_rules

  tags = var.tags
}
