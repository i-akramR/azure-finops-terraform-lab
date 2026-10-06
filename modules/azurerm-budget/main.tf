resource "azurerm_consumption_budget_resource_group" "finops" {
  name              = var.name
  resource_group_id = var.resource_group_id

  amount     = var.amount
  time_grain = "Monthly"

  time_period {
    start_date = formatdate("YYYY-MM-01'T'00:00:00Z", timestamp())
  }

  dynamic "notification" {
    for_each = var.actual_thresholds

    content {
      enabled        = true
      threshold      = notification.value
      operator       = "GreaterThan"
      threshold_type = "Actual"

      contact_groups = [
        var.action_group_id
      ]
    }
  }

  dynamic "notification" {
    for_each = var.forecast_thresholds

    content {
      enabled        = true
      threshold      = notification.value
      operator       = "GreaterThan"
      threshold_type = "Forecasted"

      contact_groups = [
        var.action_group_id
      ]
    }
  }
}
