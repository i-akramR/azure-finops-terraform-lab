variable "resource_groups" {
  description = "Map of Azure Resource Groups to create"

  type = map(object({
    resource_group_name = string
    location            = string
    tags                = optional(map(string), {})
  }))
}

variable "virtual_networks" {
  description = "Map of Azure Virtual Networks"

  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    address_space       = list(string)
    tags                = map(string)
  }))
}
variable "subnets" {
  description = "Map of Azure Subnets"

  type = map(object({
    subnet_name         = string
    vnet_name           = string
    resource_group_name = string
    address_prefixes    = list(string)
    tags                = map(string)
  }))
}

variable "windows_virtual_machines" {
  type = map(object({
    vm_name             = string
    vnet_name           = string
    subnet_name         = string
    location            = string
    resource_group_name = string
    nic_name            = string
    size                = string
    priority            = string
    license_type        = string
    admin_username      = string
    admin_password      = string
    AHB                 = bool
  }))
}



variable "linux_virtual_machines" {
  type = map(object({
    vm_name             = string
    vnet_name           = string
    subnet_name         = string
    location            = string
    resource_group_name = string
    nic_name            = string
    size                = string
    priority            = string
    eviction_policy     = string
    max_bid_price       = number
    admin_username      = string
    ssh_public_key      = string
  }))
}
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
variable "finops_alert_email" {
  description = "Email address for FinOps alerts"
  type        = string
}

variable "cost_export" {
  description = "Existing Storage Account configuration for Cost Management exports"

  type = object({
    storage_account_name = string
    resource_group_name  = string
    container_name       = string
    export_name          = string
    start_date           = string
    end_date             = string
    root_folder_path     = optional(string, "/finops")
  })
}
variable "location" {
  description = "Azure region for the FinOps lab"
  type        = string
  default     = "centralindia"
}
