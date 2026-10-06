# ---------------------------------------------------------
# Resource Group
# ---------------------------------------------------------

module "azurerm-resource-group" {
  source = "../../modules/azurerm-resource-group"

  resource_groups = var.resource_groups
  common_tags     = local.common_tags
}


# ---------------------------------------------------------
# Virtual Network
# ---------------------------------------------------------

module "azurerm-virtual-network" {
  depends_on = [
    module.azurerm-resource-group
  ]

  source = "../../modules/azurerm-virtual-network"

  virtual_networks = var.virtual_networks
}


# ---------------------------------------------------------
# Subnets
# ---------------------------------------------------------

module "azurerm-subnets" {
  depends_on = [
    module.azurerm-virtual-network
  ]

  source = "../../modules/azurerm-subnets"

  subnets = var.subnets
}


# ---------------------------------------------------------
# Virtual Machines
# ---------------------------------------------------------

module "azurerm-virtual-machine" {
  depends_on = [
    module.azurerm-subnets
  ]

  source = "../../modules/azurerm-virtual-machine"

  windows_virtual_machines = var.windows_virtual_machines
  linux_virtual_machines   = var.linux_virtual_machines
  common_tags              = local.common_tags
}
#---------------------------------------------------------
#Policy Assignment
#---------------------------------------------------------
module "azurerm-policy" {
  depends_on = [
    module.azurerm-resource-group
  ]

  source = "../../modules/azurerm-policy"

  policies           = var.policies
  resource_group_ids = module.azurerm-resource-group.resource_group_ids
  location           = var.location
}

# ---------------------------------------------------------
#Action Group
# ---------------------------------------------------------
module "azurerm-action-group" {
  source = "../../modules/azurerm-action-group"

  name                = "finops-dev-alerts"
  short_name          = "FinOpsDev"
  resource_group_name = "finops-dev-rg"
  email_address       = var.finops_alert_email
  common_tags              = local.common_tags
}

#---------------------------------------------------------
# Budget
#---------------------------------------------------------
module "azurerm-budget" {
  depends_on = [module.azurerm-action-group]

  source = "../../modules/azurerm-budget"

  name              = "finops-dev-budget"
  amount            = 50
  resource_group_id = module.azurerm-resource-group.resource_group_ids["finops"]
  actual_thresholds = [
    50,
    80
  ]

  forecast_thresholds = [
    100
  ]

  action_group_id = module.azurerm-action-group.id
}
#---------------------------------------------------------
# Cost-Export
#---------------------------------------------------------
module "azurerm-cost-export" {
  source = "../../modules/azurerm-cost-export"

  storage_account_name = var.cost_export.storage_account_name
  resource_group_name  = var.cost_export.resource_group_name
  container_name       = var.cost_export.container_name
  export_name          = var.cost_export.export_name
  start_date           = var.cost_export.start_date
  end_date             = var.cost_export.end_date
  root_folder_path     = var.cost_export.root_folder_path
}

#---------------------------------------------------------
# Anomaly-Alaert
#---------------------------------------------------------


data "azurerm_subscription" "current" {}


module "azurerm-anomaly-alert" {
  source = "../../modules/azurerm-anomaly-alert"

  name         = "finops-dev-anomaly"
  display_name = "FinOps Dev Cost Anomaly"

  subscription_id = "/subscriptions/${data.azurerm_subscription.current.subscription_id}"

  email_subject = "FinOps Dev - Cost Anomaly Detected"

  email_addresses = [
    "akkiraza.ar@gmail.com"
  ]

  message = "Unexpected Azure cost anomaly detected. Review Cost Analysis."
}
