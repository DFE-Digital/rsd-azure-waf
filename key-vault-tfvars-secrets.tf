module "azurerm_key_vault" {
  source = "github.com/DFE-Digital/terraform-azurerm-key-vault-tfvars?ref=v0.2.0"

  environment                       = local.environment
  project_name                      = local.project_name
  azure_location                    = local.azure_location
  key_vault_access_users            = local.key_vault_access_users
  key_vault_access_ipv4             = local.key_vault_access_ipv4
  tfvars_filename                   = local.tfvars_filename
  existing_resource_group           = "${local.environment}${local.project_name}"
  enable_log_analytics_workspace    = local.key_vault_tfvars_enable_log_analytics_workspace
  enable_diagnostic_storage_account = local.key_vault_tfvars_enable_diagnostic_storage_account
  tags                              = local.tags
}
