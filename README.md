# rsd-azure-front-door-waf
Azure Front Door WAF for RSD

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
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4.2 |
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | >= 1.1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.44.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azapi"></a> [azapi](#provider\_azapi) | 1.4.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.50.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_azurerm_front_door_waf"></a> [azurerm\_front\_door\_waf](#module\_azurerm\_front\_door\_waf) | github.com/DFE-Digital/terraform-azurerm-front-door-waf | v0.2.0 |

## Resources

| Name | Type |
|------|------|
| [azapi_resource.container_apps](https://registry.terraform.io/providers/Azure/azapi/latest/docs/data-sources/resource) | data source |
| [azurerm_resource_group.container_apps](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azure_location"></a> [azure\_location](#input\_azure\_location) | Azure location in which to launch resources. | `string` | n/a | yes |
| <a name="input_container_app_origins"></a> [container\_app\_origins](#input\_container\_app\_origins) | A map of Container App names to use as Origins | `map(any)` | n/a | yes |
| <a name="input_enable_latency_monitor"></a> [enable\_latency\_monitor](#input\_enable\_latency\_monitor) | Monitor latency between the Front Door and it's origin | `bool` | n/a | yes |
| <a name="input_enable_waf"></a> [enable\_waf](#input\_enable\_waf) | Enable CDN Front Door WAF | `bool` | `false` | no |
| <a name="input_endpoints"></a> [endpoints](#input\_endpoints) | A set of Endpoints that you want to sit behind this Front Door | `map(any)` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name. Will be used along with `project_name` as a prefix for all resources. | `string` | n/a | yes |
| <a name="input_monitor_action_group_id"></a> [monitor\_action\_group\_id](#input\_monitor\_action\_group\_id) | Specify the Action Group ID that you want to send the Latency monitor alerts to. Required if 'enable\_latency\_monitor' is true | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Project name. Will be used along with `environment` as a prefix for all resources. | `string` | n/a | yes |
| <a name="input_response_timeout"></a> [response\_timeout](#input\_response\_timeout) | Azure CDN Front Door response timeout in seconds | `number` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | Azure CDN Front Door SKU | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be applied to all resources | `map(string)` | n/a | yes |
| <a name="input_waf_custom_rules"></a> [waf\_custom\_rules](#input\_waf\_custom\_rules) | Map of all Custom rules you want to apply to the WAF | `map(any)` | n/a | yes |
| <a name="input_waf_enable_rate_limiting"></a> [waf\_enable\_rate\_limiting](#input\_waf\_enable\_rate\_limiting) | Deploy a Rate Limiting Policy on the Front Door WAF | `bool` | n/a | yes |
| <a name="input_waf_managed_rulesets"></a> [waf\_managed\_rulesets](#input\_waf\_managed\_rulesets) | Map of all Managed rules you want to apply to the WAF, including any overrides | `map(any)` | <pre>{<br>  "BotProtection": {<br>    "action": "Block",<br>    "version": "preview-0.1"<br>  },<br>  "DefaultRuleSet": {<br>    "action": "Block",<br>    "version": "1.0"<br>  }<br>}</pre> | no |
| <a name="input_waf_mode"></a> [waf\_mode](#input\_waf\_mode) | CDN Front Door WAF mode | `string` | n/a | yes |
| <a name="input_waf_rate_limiting_bypass_ip_list"></a> [waf\_rate\_limiting\_bypass\_ip\_list](#input\_waf\_rate\_limiting\_bypass\_ip\_list) | List if IP CIDRs to bypass the Rate Limit Policy | `list(string)` | n/a | yes |
| <a name="input_waf_rate_limiting_duration_in_minutes"></a> [waf\_rate\_limiting\_duration\_in\_minutes](#input\_waf\_rate\_limiting\_duration\_in\_minutes) | Number of minutes to BLOCK requests that hit the Rate Limit threshold | `number` | n/a | yes |
| <a name="input_waf_rate_limiting_threshold"></a> [waf\_rate\_limiting\_threshold](#input\_waf\_rate\_limiting\_threshold) | Maximum number of concurrent requests before Rate Limiting policy is applied | `number` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->