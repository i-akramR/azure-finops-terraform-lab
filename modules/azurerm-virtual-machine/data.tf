data "azurerm_subnet" "snet" {
  for_each = merge(
    var.windows_virtual_machines,
    var.linux_virtual_machines
  )

  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.resource_group_name
}
