resource "azurerm_monitor_action_group" "finops" {
  name                = "finops-dev-alerts"
  resource_group_name = var.resource_group_name
  short_name          = "finops"

  email_receiver {
    name                    = "finops-email"
    email_address           = var.email_address
    use_common_alert_schema = true
  }
  tags = var.common_tags
}
