resource "azurerm_resource_group" "rgroup" {
  for_each = var.resource_groups

  name     = each.value.resource_group_name
  location = each.value.location

  tags = merge(
    var.common_tags,
    each.value.tags
  )
}
