resource "azurerm_resource_group_policy_assignment" "policy" {
  for_each = var.policies

  name                 = each.value.name
  display_name         = each.value.display_name
  policy_definition_id = each.value.policy_definition_id

  resource_group_id = var.resource_group_ids[each.value.resource_group_key]

  enforce  = true
  location = var.location

  parameters = jsonencode(each.value.parameters)

  identity {
    type = "SystemAssigned"
  }
}
