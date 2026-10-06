data "azurerm_subscription" "current" {}

data "azurerm_storage_account" "cost_export" {
  name                = var.storage_account_name
  resource_group_name = var.resource_group_name
}

data "azurerm_storage_container" "cost_export" {
  name               = var.container_name
  storage_account_id = data.azurerm_storage_account.cost_export.id
}

resource "azurerm_subscription_cost_management_export" "daily" {
  name            = var.export_name
  subscription_id = data.azurerm_subscription.current.id

  recurrence_type              = "Daily"
  recurrence_period_start_date = var.start_date
  recurrence_period_end_date   = var.end_date

  file_format = "Csv"

  export_data_storage_location {
    container_id     = data.azurerm_storage_container.cost_export.id
    root_folder_path = var.root_folder_path
  }

  export_data_options {
    type       = "ActualCost"
    time_frame = "MonthToDate"
  }

  active = true
}
