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