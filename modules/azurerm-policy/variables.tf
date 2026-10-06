variable "policies" {
  description = "Azure Policy assignments"

  type = map(object({
    name                 = string
    display_name         = string
    policy_definition_id = string
    resource_group_key   = string
    parameters           = optional(map(any), {})
  }))
}

variable "resource_group_ids" {
  description = "Resource Group IDs keyed by resource group name"

  type = map(string)
}
variable "location" {
  description = "Azure region for the policy assignment managed identity"
  type        = string
}
