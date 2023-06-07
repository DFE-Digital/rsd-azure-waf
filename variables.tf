variable "environment" {
  description = "Environment name. Will be used along with `project_name` as a prefix for all resources."
  type        = string
}

variable "project_name" {
  description = "Project name. Will be used along with `environment` as a prefix for all resources."
  type        = string
}

variable "azure_location" {
  description = "Azure location in which to launch resources."
  type        = string
}

variable "tags" {
  description = "Tags to be applied to all resources"
  type        = map(string)
}

variable "key_vault_access_users" {
  description = "List of users that require access to the Key Vault where tfvars are stored. This should be a list of User Principle Names (Found in Active Directory) that need to run terraform"
  type        = list(string)
}

variable "key_vault_access_ipv4" {
  description = "List of IPv4 Addresses that are permitted to access the Key Vault"
  type        = list(string)
}

variable "tfvars_filename" {
  description = "tfvars filename. This file is uploaded and stored encrupted within Key Vault, to ensure that the latest tfvars are stored in a shared place."
  type        = string
}

variable "key_vault_tfvars_enable_log_analytics_workspace" {
  description = "When enabled, creates a Log Analyics Workspace for the tfvars Key Vault"
  type        = bool
  default     = true
}

variable "key_vault_tfvars_enable_diagnostic_storage_account" {
  description = "When enabled, creates a Storage Account for the tfvars key vault diagnostic logs"
  type        = bool
  default     = true
}

variable "cdn_sku" {
  description = "Azure CDN Front Door SKU"
  type        = string
}

variable "cdn_response_timeout" {
  description = "Azure CDN Front Door response timeout in seconds"
  type        = number
}

variable "enable_waf" {
  description = "Enable CDN Front Door WAF"
  type        = bool
  default     = false
}

variable "waf_mode" {
  description = "CDN Front Door WAF mode"
  type        = string
}

variable "waf_enable_rate_limiting" {
  description = "Deploy a Rate Limiting Policy on the Front Door WAF"
  type        = bool
}

variable "waf_rate_limiting_duration_in_minutes" {
  description = "Number of minutes to BLOCK requests that hit the Rate Limit threshold"
  type        = number
}

variable "waf_rate_limiting_threshold" {
  description = "Maximum number of concurrent requests before Rate Limiting policy is applied"
  type        = number
}

variable "waf_rate_limiting_bypass_ip_list" {
  description = "List if IP CIDRs to bypass the Rate Limit Policy"
  type        = list(string)
}

variable "waf_managed_rulesets" {
  description = "Map of all Managed rules you want to apply to the WAF, including any overrides"
  type = map(object({
    version : string,
    action : string,
    exclusions : optional(map(object({
      match_variable : string,
      operator : string,
      selector : string
    })), {})
    overrides : optional(map(map(object({
      action : string,
      exclusions : optional(map(object({
        match_variable : string,
        operator : string,
        selector : string
      })), {})
    }))), {})
  }))
  default = {}
}

variable "waf_custom_rules" {
  description = "Map of all Custom rules you want to apply to the WAF"
  type = map(object({
    priority : number,
    action : string,
    match_conditions : map(object({
      match_variable : string,
      match_values : list(string),
      operator : string,
      selector : optional(string, null)
    }))
  }))
  default = {}
}

variable "cdn_container_app_targets" {
  description = "A map of Container Apps to configure as CDN targets"
  type = map(object({
    resource_group : string,
    create_custom_domain : optional(bool, false),
    enable_health_probe : optional(bool, true),
    health_probe_interval : optional(number, 60),
    health_probe_request_type : optional(string, "HEAD"),
    health_probe_path : optional(string, "/"),
    cdn_add_response_headers : optional(list(object({
      name : string,
      value : string
      })
    ), []),
    cdn_add_request_headers : optional(list(object({
      name : string,
      value : string
      })
    ), []),
    cdn_remove_response_headers : optional(list(string), []),
    cdn_remove_request_headers : optional(list(string), [])
  }))
  default = {}
}

variable "cdn_web_app_service_targets" {
  description = "A map of Web App Services to configure as CDN targets"
  type = map(object({
    resource_group : string,
    os : string
    create_custom_domain : optional(bool, false),
    enable_health_probe : optional(bool, true)
    health_probe_interval : optional(number, 60),
    health_probe_request_type : optional(string, "HEAD"),
    health_probe_path : optional(string, "/"),
    cdn_add_response_headers : optional(list(object({
      name : string,
      value : string
      })
    ), []),
    cdn_add_request_headers : optional(list(object({
      name : string,
      value : string
      })
    ), []),
    cdn_remove_response_headers : optional(list(string), []),
    cdn_remove_request_headers : optional(list(string), [])
  }))
  default = {}
}

variable "cdn_add_response_headers" {
  description = "List of response headers to add at the CDN Front Door for all endpoints `[{ \"Name\" = \"Strict-Transport-Security\", \"value\" = \"max-age=31536000\" }]`"
  type        = list(map(string))
  default     = []
}

variable "cdn_remove_response_headers" {
  description = "List of response headers to remove at the CDN Front Door for all endpoints"
  type        = list(string)
  default     = []
}
