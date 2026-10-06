output "storage_account_id" {
  description = "Existing Storage Account ID"

  value = data.azurerm_storage_account.cost_export.id
}

output "storage_account_name" {
  description = "Existing Storage Account name"

  value = data.azurerm_storage_account.cost_export.name
}

output "container_name" {
  description = "Existing container name"

  value = data.azurerm_storage_container.cost_export.name
}
