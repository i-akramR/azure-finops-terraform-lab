variable "resource_groups" {
  description = "Resource groups to create"

  type = map(object({
    resource_group_name = string
    location            = string
    tags                = optional(map(string), {})
  }))
}

variable "common_tags" {
  description = "Common tags applied to all resource groups"

  type    = map(string)
  default = {}
}

