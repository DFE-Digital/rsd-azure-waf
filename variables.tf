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
    enable_health_probe : optional(bool, true)
    health_probe_interval : optional(number, 60),
    health_probe_request_type : optional(string, "HEAD"),
    health_probe_path : optional(string, "/")
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
    health_probe_path : optional(string, "/")
  }))
  default = {}
}
