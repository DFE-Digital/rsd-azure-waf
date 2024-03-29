locals {
  environment     = var.environment
  project_name    = var.project_name
  azure_location  = var.azure_location
  resource_prefix = "${local.environment}${local.project_name}"

  key_vault_app_gateway_certificates_access_users      = var.key_vault_app_gateway_certificates_access_users
  key_vault_app_gateway_certificates_access_ipv4       = var.key_vault_app_gateway_certificates_access_ipv4
  key_vault_app_gateway_certificates_access_subnet_ids = var.key_vault_app_gateway_certificates_access_subnet_ids

  tfvars_filename    = var.tfvars_filename
  tfvars_access_ipv4 = var.tfvars_access_ipv4

  existing_logic_app_workflow = var.existing_logic_app_workflow
  monitor_email_receivers     = var.monitor_email_receivers

  response_request_timeout = var.response_request_timeout
  container_app_targets    = var.container_app_targets
  web_app_service_targets  = var.web_app_service_targets
  windows_web_app_service_targets = {
    for web_app_service_target_name, web_app_service_target_value in local.web_app_service_targets : web_app_service_target_name => web_app_service_target_value if web_app_service_target_value.os == "Windows"
  }
  linux_web_app_service_targets = {
    for web_app_service_target_name, web_app_service_target_value in local.web_app_service_targets : web_app_service_target_name => web_app_service_target_value if web_app_service_target_value.os == "Linux"
  }
  waf_targets = merge(
    {
      for container_app_target_name, container_app_target_value in local.container_app_targets : replace(container_app_target_name, local.environment, "") => merge(
        {
          domain = data.azurerm_container_app.container_apps[container_app_target_name].ingress[0].fqdn
        },
        container_app_target_value
      )
    },
    {
      for windows_web_app_service_target_name, windows_web_app_service_target_value in local.windows_web_app_service_targets : replace(windows_web_app_service_target_name, local.environment, "") => merge(
        {
          domain = data.azurerm_windows_web_app.web_apps[windows_web_app_service_target_name].default_hostname
        },
        windows_web_app_service_target_value
      )
    },
    {
      for linux_web_app_service_target_name, linux_web_app_service_target_value in local.linux_web_app_service_targets : replace(linux_web_app_service_target_name, local.environment, "") => merge(
        {
          domain = data.azurerm_linux_web_app.web_apps[linux_web_app_service_target_name].default_hostname
        },
        linux_web_app_service_target_value
      )
    }
  )

  cdn_add_response_headers    = var.cdn_add_response_headers
  cdn_remove_response_headers = var.cdn_remove_response_headers

  enable_waf       = var.enable_waf
  waf_application  = var.waf_application
  waf_mode         = var.waf_mode
  waf_custom_rules = var.waf_custom_rules

  app_gateway_v2_waf_managed_rulesets            = var.app_gateway_v2_waf_managed_rulesets
  app_gateway_v2_waf_managed_rulesets_exclusions = var.app_gateway_v2_waf_managed_rulesets_exclusions

  tags = var.tags
}
