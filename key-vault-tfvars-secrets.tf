## Can't use this until the Key Vault has the ability to toggle-off Diagnostic Settings as this repo doesn't have scope
## for any diagnostic sinks
# module "azurerm_key_vault" {
#   source = "github.com/DFE-Digital/terraform-azurerm-key-vault-tfvars?ref=v0.1.1"

#   environment            = local.environment
#   project_name           = local.project_name
#   resource_group_name    = module.azurerm_front_door_waf.azurerm_resource_group_default.name
#   azure_location         = local.azure_location
#   key_vault_access_users = local.key_vault_access_users
#   tfvars_filename        = local.tfvars_filename
#   tags                   = local.tags
# }
