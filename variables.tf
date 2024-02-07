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

variable "key_vault_app_gateway_certificates_access_users" {
  description = "List of users that require access to the App Gateway Certificates Key Vault. This should be a list of User Principle Names (Found in Active Directory) that need to run terraform"
  type        = list(string)
}

variable "key_vault_app_gateway_certificates_access_ipv4" {
  description = "List of IPv4 Addresses that are permitted to access the App Gateway Certificates Key Vault"
  type        = list(string)
}

variable "key_vault_app_gateway_certificates_access_subnet_ids" {
  description = "List of Azure Subnet IDs that are permitted to access the App Gateway Certificates Key Vault"
  type        = list(string)
  default     = []
}

variable "response_request_timeout" {
  description = "Azure CDN Front Door response or App Gateway V2 request timeout in seconds"
  type        = number
}

variable "enable_waf" {
  description = "Enable WAF"
  type        = bool
  default     = false
}

variable "waf_application" {
  description = "Which product to apply the WAF to. Must be either CDN or AppGatewayV2"
  type        = string
}

variable "waf_custom_rules" {
  description = "Map of all Custom rules you want to apply to the WAF"
  type = map(object({
    priority : number,
    action : string
    match_conditions : map(object({
      match_variable : string,
      match_values : optional(list(string), []),
      operator : optional(string, "Any"),
      selector : optional(string, ""),
    }))
  }))
  default = {}
}

variable "waf_mode" {
  description = "WAF mode"
  type        = string
}

variable "container_app_targets" {
  description = "A map of Container Apps to configure as Front Door or App Gateway V2 targets"
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

variable "web_app_service_targets" {
  description = "A map of Web App Services to configure as Front Door or App Gateway V2 targets"
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

variable "app_gateway_v2_waf_managed_rulesets" {
  description = "Map of all Managed rules you want to apply to the App Gateway WAF, including any overrides"
  type = map(object({
    version : string,
    overrides : optional(map(object({
      rules : map(object({
        enabled : bool,
        action : optional(string, "Block")
      }))
    })), {})
  }))
  default = {
    "OWASP" = {
      version = "3.2"
    },
    "Microsoft_BotManagerRuleSet" = {
      version = "1.0"
    }
  }
}

variable "app_gateway_v2_waf_managed_rulesets_exclusions" {
  description = "Map of all exclusions and the associated Managed rules to apply to the App Gateway WAF"
  type = map(object({
    match_variable : string,
    selector : string,
    selector_match_operator : string,
    excluded_rule_set : map(object({
      version : string,
      rule_group_name : string,
      excluded_rules : list(string)
    }))
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

variable "existing_logic_app_workflow" {
  description = "Name, and Resource Group of an existing Logic App Workflow"
  type = object({
    name : string
    resource_group_name : string
  })
  default = {
    name                = ""
    resource_group_name = ""
  }
}

variable "monitor_email_receivers" {
  description = "A list of email addresses that should be notified by monitoring alerts"
  type        = list(string)
  default     = []
}
