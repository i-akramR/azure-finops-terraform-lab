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
    nic_name             = string
    size                = string
    priority            = string
    eviction_policy     = string
    max_bid_price        = number
    admin_username      = string
    ssh_public_key      = string
  }))
}
variable "common_tags" {
  description = "Common tags applied to all VMs"

  type = map(string)
}
