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

variable "sku" {
  description = "Azure CDN Front Door SKU"
  type        = string
}

variable "enable_latency_monitor" {
  description = "Monitor latency between the Front Door and it's origin"
  type        = bool
}

variable "monitor_action_group_id" {
  description = "Specify the Action Group ID that you want to send the Latency monitor alerts to. Required if 'enable_latency_monitor' is true"
  type        = string
}

variable "response_timeout" {
  description = "Azure CDN Front Door response timeout in seconds"
  type        = number
}

variable "enable_waf" {
  description = "Enable CDN Front Door WAF"
  type        = bool
  default     = false
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
  description = "Map of all Managed rules you want to apply including any overrides"
  type        = map(any)
  default = {
    "BotProtection" : {
      version : "preview-0.1",
      action : "Block"
    },
    "DefaultRuleSet" : {
      version : "1.0",
      action : "Block"
    }
  }
}

variable "origin_groups" {
  description = "A set of Endpoints that you want to sit behind this Front Door"
  type        = map(any)
}

variable "container_app_origins" {
  description = "A map of Container App names to use as Origins"
  type        = map(any)
}
