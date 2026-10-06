variable "name" {
  description = "Action Group name"
  type        = string
}

variable "short_name" {
  description = "Action Group short name"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group containing the Action Group"
  type        = string
}

variable "email_address" {
  description = "Email address for FinOps alerts"
  type        = string
}
variable "common_tags" {
  description = "Common tags applied to all VMs"

  type = map(string)
}