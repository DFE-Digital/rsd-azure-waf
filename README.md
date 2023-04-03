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
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.50.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_azurerm_front_door_waf"></a> [azurerm\_front\_door\_waf](#module\_azurerm\_front\_door\_waf) | github.com/DFE-Digital/terraform-azurerm-front-door-waf | v0.1.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_cdn_frontdoor_endpoint.origins](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/cdn_frontdoor_endpoint) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azure_location"></a> [azure\_location](#input\_azure\_location) | Azure location in which to launch resources. | `string` | n/a | yes |
| <a name="input_certificates"></a> [certificates](#input\_certificates) | Customer managed certificates (.pfx) | `map(any)` | n/a | yes |
| <a name="input_custom_domains"></a> [custom\_domains](#input\_custom\_domains) | Azure CDN Front Door custom domains. If they are within the DNS zone (optionally created), the Validation TXT records and ALIAS/CNAME records will be created | `map(any)` | n/a | yes |
| <a name="input_enable_health_probe"></a> [enable\_health\_probe](#input\_enable\_health\_probe) | Enable CDN Front Door health probe | `bool` | n/a | yes |
| <a name="input_enable_latency_monitor"></a> [enable\_latency\_monitor](#input\_enable\_latency\_monitor) | Monitor latency between the Front Door and it's origin | `bool` | n/a | yes |
| <a name="input_enable_waf"></a> [enable\_waf](#input\_enable\_waf) | Enable CDN Front Door WAF | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name. Will be used along with `project_name` as a prefix for all resources. | `string` | n/a | yes |
| <a name="input_key_vault_access_users"></a> [key\_vault\_access\_users](#input\_key\_vault\_access\_users) | A list of Azure AD Users that are granted Secret & Certificate management permissions to the Key Vault | `list(string)` | n/a | yes |
| <a name="input_key_vault_allow_ipv4_list"></a> [key\_vault\_allow\_ipv4\_list](#input\_key\_vault\_allow\_ipv4\_list) | A list of IPv4 addresses to permit access to the Key Vault that holds the TLS Certificates | `list(string)` | n/a | yes |
| <a name="input_origins"></a> [origins](#input\_origins) | A set of Front Door Endpoints that you want to sit behind this Front Door | `map(any)` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Project name. Will be used along with `environment` as a prefix for all resources. | `string` | n/a | yes |
| <a name="input_response_timeout"></a> [response\_timeout](#input\_response\_timeout) | Azure CDN Front Door response timeout in seconds | `number` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | Azure CDN Front Door SKU | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be applied to all resources | `map(string)` | n/a | yes |
| <a name="input_tfvars_filename"></a> [tfvars\_filename](#input\_tfvars\_filename) | tfvars filename. This file is uploaded and stored encrupted within Key Vault, to ensure that the latest tfvars are stored in a shared place. | `string` | n/a | yes |
| <a name="input_waf_enable_bot_protection"></a> [waf\_enable\_bot\_protection](#input\_waf\_enable\_bot\_protection) | Deploy a Bot Protection Policy on the Front Door WAF | `bool` | n/a | yes |
| <a name="input_waf_enable_default_ruleset"></a> [waf\_enable\_default\_ruleset](#input\_waf\_enable\_default\_ruleset) | Deploy a Managed DRS Policy on the Front Door WAF | `bool` | n/a | yes |
| <a name="input_waf_enable_rate_limiting"></a> [waf\_enable\_rate\_limiting](#input\_waf\_enable\_rate\_limiting) | Deploy a Rate Limiting Policy on the Front Door WAF | `bool` | n/a | yes |
| <a name="input_waf_rate_limiting_bypass_ip_list"></a> [waf\_rate\_limiting\_bypass\_ip\_list](#input\_waf\_rate\_limiting\_bypass\_ip\_list) | List if IP CIDRs to bypass the Rate Limit Policy | `list(string)` | n/a | yes |
| <a name="input_waf_rate_limiting_duration_in_minutes"></a> [waf\_rate\_limiting\_duration\_in\_minutes](#input\_waf\_rate\_limiting\_duration\_in\_minutes) | Number of minutes to BLOCK requests that hit the Rate Limit threshold | `number` | n/a | yes |
| <a name="input_waf_rate_limiting_threshold"></a> [waf\_rate\_limiting\_threshold](#input\_waf\_rate\_limiting\_threshold) | Maximum number of concurrent requests before Rate Limiting policy is applied | `number` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->