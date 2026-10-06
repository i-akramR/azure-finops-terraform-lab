
resource "azurerm_cost_anomaly_alert" "finops" {
  name            = var.name
  display_name    = var.display_name
  subscription_id = var.subscription_id

  email_subject   = var.email_subject
  email_addresses = var.email_addresses

  message = var.message
}
