variable "subscription_name" {
  type        = string
  description = "name of subscription"
}

variable "management_group_id" {
  type        = string
  description = "ID of the parent management group this subscription will be added under"
  default     = "azure-poe"
}

variable "is_connectivity_sub" {
  type        = bool
  description = "Is this subscription used as a connectivity subscription?"
  default     = false
}

variable "deploy_default_resources" {
  type        = bool
  description = "Deploy default resources?"
  default     = false
}

variable "key" {
  type = number
}

variable "enable_management_group_association" {
  type    = bool
  default = false
}

variable "is_arc_enabled" {
  type    = bool
  default = false
}

variable "is_avs_enabled" {
  type    = bool
  default = false
}