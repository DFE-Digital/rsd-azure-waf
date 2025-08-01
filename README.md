# rsd-azure-front-door-waf
Azure WAF for RSD

[![Terraform CI](https://github.com/DFE-Digital/rsd-azure-front-door-waf/actions/workflows/continuous-integration-terraform.yml/badge.svg?branch=main)](https://github.com/DFE-Digital/rsd-azure-front-door-waf/actions/workflows/continuous-integration-terraform.yml/?branch=main)
[![Tflint](https://github.com/DFE-Digital/rsd-azure-front-door-waf/actions/workflows/continuous-integration-tflint.yml/badge.svg?branch=main)](https://github.com/DFE-Digital/rsd-azure-front-door-waf/actions/workflows/continuous-integration-tflint.yml?branch=main)
[![Tfsec](https://github.com/DFE-Digital/rsd-azure-front-door-waf/actions/workflows/continuous-integration-tfsec.yml/badge.svg?branch=main)](https://github.com/DFE-Digital/rsd-azure-front-door-waf/actions/workflows/continuous-integration-tfsec.yml?branch=main)

#### Configuring the storage backend

The Terraform state is stored remotely in Azure, this allows multiple team members to
make changes and means the state file is backed up. The state file contains
sensitive information so access to it should be restricted, and it should be stored
encrypted at rest.

##### Create a new storage backend

This step only needs to be done once per environment.
If it has already been created, obtain the storage backend attributes and skip to the next step.

The [Azure tutorial](https://docs.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage) outlines the steps to create a storage account and container for the state file. You will need:

- subscription_id: The id of the azure Subscription the resource group belongs to
- resource_group_name: The name of the resource group used for the Azure Storage account.
- storage_account_name: The name of the Azure Storage account.
- container_name: The name of the blob container.
- key: The name of the state store file to be created.

##### Create a backend configuration file

Create a new file named `backend.vars` with the following content:

```
subscription_id      = [the ID of the Azure subscription]
resource_group_name  = [the name of the Azure resource group]
storage_account_name = [the name of the Azure Storage account]
container_name       = [the name of the blob container]
key                  = "terraform.tstate"
```

#### Azure resources

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.9 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | ~> 3.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.38.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.2.4 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_waf"></a> [waf](#module\_waf) | github.com/DFE-Digital/terraform-azurerm-front-door-app-gateway-waf | v1.6.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_storage_account.tfvars](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_account_network_rules.tfvars](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account_network_rules) | resource |
| [azurerm_storage_blob.dfe_403](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_blob) | resource |
| [azurerm_storage_blob.dfe_502](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_blob) | resource |
| [azurerm_storage_blob.govuk_403](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_blob) | resource |
| [azurerm_storage_blob.govuk_502](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_blob) | resource |
| [azurerm_storage_blob.tfvars](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_blob) | resource |
| [azurerm_storage_blob.waftfvars](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_blob) | resource |
| [azurerm_storage_container.tfvars](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [null_resource.tfvars](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.waftfvars](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [azurerm_container_app.container_apps](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/container_app) | data source |
| [azurerm_linux_web_app.web_apps](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/linux_web_app) | data source |
| [azurerm_resource_group.container_apps](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_windows_web_app.web_apps](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/windows_web_app) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_gateway_v2_waf_managed_rulesets"></a> [app\_gateway\_v2\_waf\_managed\_rulesets](#input\_app\_gateway\_v2\_waf\_managed\_rulesets) | Map of all Managed rules you want to apply to the App Gateway WAF, including any overrides | <pre>map(object({<br/>    version : string,<br/>    overrides : optional(map(object({<br/>      rules : map(object({<br/>        enabled : bool,<br/>        action : optional(string, "Block")<br/>      }))<br/>    })), {})<br/>  }))</pre> | <pre>{<br/>  "Microsoft_BotManagerRuleSet": {<br/>    "version": "1.0"<br/>  },<br/>  "OWASP": {<br/>    "version": "3.2"<br/>  }<br/>}</pre> | no |
| <a name="input_app_gateway_v2_waf_managed_rulesets_exclusions"></a> [app\_gateway\_v2\_waf\_managed\_rulesets\_exclusions](#input\_app\_gateway\_v2\_waf\_managed\_rulesets\_exclusions) | Map of all exclusions and the associated Managed rules to apply to the App Gateway WAF | <pre>map(object({<br/>    match_variable : string,<br/>    selector : string,<br/>    selector_match_operator : string,<br/>    excluded_rule_set : map(object({<br/>      version : string,<br/>      rule_group_name : string,<br/>      excluded_rules : list(string)<br/>    }))<br/>  }))</pre> | `{}` | no |
| <a name="input_azure_client_id"></a> [azure\_client\_id](#input\_azure\_client\_id) | Service Principal Client ID | `string` | n/a | yes |
| <a name="input_azure_client_secret"></a> [azure\_client\_secret](#input\_azure\_client\_secret) | Service Principal Client Secret | `string` | n/a | yes |
| <a name="input_azure_location"></a> [azure\_location](#input\_azure\_location) | Azure location in which to launch resources. | `string` | n/a | yes |
| <a name="input_azure_subscription_id"></a> [azure\_subscription\_id](#input\_azure\_subscription\_id) | Service Principal Subscription ID | `string` | n/a | yes |
| <a name="input_azure_tenant_id"></a> [azure\_tenant\_id](#input\_azure\_tenant\_id) | Service Principal Tenant ID | `string` | n/a | yes |
| <a name="input_cdn_add_response_headers"></a> [cdn\_add\_response\_headers](#input\_cdn\_add\_response\_headers) | List of response headers to add at the CDN Front Door for all endpoints `[{ "Name" = "Strict-Transport-Security", "value" = "max-age=31536000" }]` | `list(map(string))` | `[]` | no |
| <a name="input_cdn_remove_response_headers"></a> [cdn\_remove\_response\_headers](#input\_cdn\_remove\_response\_headers) | List of response headers to remove at the CDN Front Door for all endpoints | `list(string)` | `[]` | no |
| <a name="input_container_app_targets"></a> [container\_app\_targets](#input\_container\_app\_targets) | A map of Container Apps to configure as Front Door or App Gateway V2 targets | <pre>map(object({<br/>    resource_group : string,<br/>    create_custom_domain : optional(bool, false),<br/>    enable_health_probe : optional(bool, true),<br/>    health_probe_interval : optional(number, 60),<br/>    health_probe_request_type : optional(string, "HEAD"),<br/>    health_probe_path : optional(string, "/"),<br/>    vnet_peering_target : optional(object({<br/>      name : string,<br/>      resource_group_name : string<br/>    }))<br/>    cdn_add_response_headers : optional(list(object({<br/>      name : string,<br/>      value : string<br/>      })<br/>    ), []),<br/>    cdn_add_request_headers : optional(list(object({<br/>      name : string,<br/>      value : string<br/>      })<br/>    ), []),<br/>    cdn_remove_response_headers : optional(list(string), []),<br/>    cdn_remove_request_headers : optional(list(string), []),<br/>    custom_errors : optional(object({<br/>      error_page_directory : string,<br/>      error_pages : map(string)<br/>    }), null)<br/>  }))</pre> | `{}` | no |
| <a name="input_enable_waf"></a> [enable\_waf](#input\_enable\_waf) | Enable WAF | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name. Will be used along with `project_name` as a prefix for all resources. | `string` | n/a | yes |
| <a name="input_existing_logic_app_workflow"></a> [existing\_logic\_app\_workflow](#input\_existing\_logic\_app\_workflow) | Name, and Resource Group of an existing Logic App Workflow | <pre>object({<br/>    name : string<br/>    resource_group_name : string<br/>  })</pre> | <pre>{<br/>  "name": "",<br/>  "resource_group_name": ""<br/>}</pre> | no |
| <a name="input_monitor_email_receivers"></a> [monitor\_email\_receivers](#input\_monitor\_email\_receivers) | A list of email addresses that should be notified by monitoring alerts | `list(string)` | `[]` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Project name. Will be used along with `environment` as a prefix for all resources. | `string` | n/a | yes |
| <a name="input_response_request_timeout"></a> [response\_request\_timeout](#input\_response\_request\_timeout) | Azure CDN Front Door response or App Gateway V2 request timeout in seconds | `number` | n/a | yes |
| <a name="input_restrict_app_gateway_v2_to_front_door_inbound_only"></a> [restrict\_app\_gateway\_v2\_to\_front\_door\_inbound\_only](#input\_restrict\_app\_gateway\_v2\_to\_front\_door\_inbound\_only) | Restricts access to the App Gateway V2 by creating a network security group that only allows 'AzureFrontDoor.Backend' inbound, and attaches it to the subnet of the application gateway. | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be applied to all resources | `map(string)` | n/a | yes |
| <a name="input_tfvars_access_ipv4"></a> [tfvars\_access\_ipv4](#input\_tfvars\_access\_ipv4) | List of IPv4 Addresses that are permitted to access the tfvars Storage Account | `list(string)` | `[]` | no |
| <a name="input_tfvars_filename"></a> [tfvars\_filename](#input\_tfvars\_filename) | Name of the TF Vars file | `string` | `"terraform.tfvars"` | no |
| <a name="input_virtual_network_address_space"></a> [virtual\_network\_address\_space](#input\_virtual\_network\_address\_space) | Virtual Network address space CIDR | `string` | `"172.16.0.0/12"` | no |
| <a name="input_waf_application"></a> [waf\_application](#input\_waf\_application) | Which product to apply the WAF to. Must be either CDN or AppGatewayV2 | `string` | n/a | yes |
| <a name="input_waf_custom_rules"></a> [waf\_custom\_rules](#input\_waf\_custom\_rules) | Map of all Custom rules you want to apply to the WAF | <pre>map(object({<br/>    priority : number,<br/>    action : string<br/>    match_conditions : map(object({<br/>      match_variable : string,<br/>      match_values : optional(list(string), []),<br/>      operator : optional(string, "Any"),<br/>      selector : optional(string, ""),<br/>      negation_condition : optional(bool, false),<br/>    }))<br/>  }))</pre> | `{}` | no |
| <a name="input_waf_mode"></a> [waf\_mode](#input\_waf\_mode) | WAF mode | `string` | n/a | yes |
| <a name="input_waf_tfvars_filename"></a> [waf\_tfvars\_filename](#input\_waf\_tfvars\_filename) | Name of the TF Vars file that contains the WAF rules | `string` | `"waf.tfvars"` | no |
| <a name="input_web_app_service_targets"></a> [web\_app\_service\_targets](#input\_web\_app\_service\_targets) | A map of Web App Services to configure as Front Door or App Gateway V2 targets | <pre>map(object({<br/>    resource_group : string,<br/>    os : string<br/>    create_custom_domain : optional(bool, false),<br/>    enable_health_probe : optional(bool, true)<br/>    health_probe_interval : optional(number, 60),<br/>    health_probe_request_type : optional(string, "HEAD"),<br/>    health_probe_path : optional(string, "/"),<br/>    cdn_add_response_headers : optional(list(object({<br/>      name : string,<br/>      value : string<br/>      })<br/>    ), []),<br/>    cdn_add_request_headers : optional(list(object({<br/>      name : string,<br/>      value : string<br/>      })<br/>    ), []),<br/>    cdn_remove_response_headers : optional(list(string), []),<br/>    cdn_remove_request_headers : optional(list(string), [])<br/>  }))</pre> | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
