output "resource_group_ids" {
  description = "Resource Group IDs"

  value = {
    for key, rg in azurerm_resource_group.rgroup :
    key => rg.id
  }
}
