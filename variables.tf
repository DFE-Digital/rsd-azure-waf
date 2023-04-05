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

variable "key_vault_access_users" {
  description = "A list of Azure AD Users that are granted Secret & Certificate management permissions to the Key Vault"
  type        = list(string)
}

variable "tags" {
  description = "Tags to be applied to all resources"
  type        = map(string)
}

variable "sku" {
  description = "Azure CDN Front Door SKU"
  type        = string
}

variable "key_vault_allow_ipv4_list" {
  description = "A list of IPv4 addresses to permit access to the Key Vault that holds the TLS Certificates"
  type        = list(string)
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

variable "certificates" {
  description = "Customer managed certificates (.pfx)"
  type        = map(any)
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

variable "waf_enable_bot_protection" {
  description = "Deploy a Bot Protection Policy on the Front Door WAF"
  type        = bool
}

variable "waf_enable_default_ruleset" {
  description = "Deploy a Managed DRS Policy on the Front Door WAF"
  type        = bool
}

variable "origin_groups" {
  description = "A set of Endpoints that you want to sit behind this Front Door"
  type        = map(any)
}
