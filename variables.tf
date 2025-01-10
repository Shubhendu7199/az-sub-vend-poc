variable "opgroup" {
  description = "Name of the Group, used for connectivity subscriptions to derive the Terraform workspace name"
  type        = string
}

variable "deploy_default_resources" {
  type        = bool
  description = "Deploy default resources?"
  default     = false
}

variable "subscription_list" {
  type = list(object({
    key                                 = number
    subscription_name                   = string
    management_group_id                 = string
    is_connectivity_sub                 = bool
    environment                         = optional(string, "Production")
    connectivity_hub_locations          = optional(list(string), null)
    is_arc_enabled                      = optional(bool, false)
    is_avs_enabled                      = optional(bool, false)
    deploy_default_resources            = optional(bool, false)
    enable_management_group_association = bool
    tags                                = optional(map(any))
    is_paas                             = optional(bool, false)
  }))
}

variable "subscription_id" {
  type    = string
  default = "10e0ad56-8242-45e7-b95a-a64f4eb4542f" # Management Subscription Id - this subscription ID is only required for Authorization and could be anything. It has 0 actual use. 
}

variable "tfc_organization_name" {
  type        = string
  description = ""
}

variable "tfc_project_name" {
  type        = string
  description = ""
}

variable "tfc_hostname" {
  type        = string
  description = ""

}
