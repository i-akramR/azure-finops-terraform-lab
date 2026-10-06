variable "name" {
  description = "Budget name"
  type        = string
}

variable "amount" {
  description = "Budget amount"
  type        = number
}

variable "resource_group_id" {
  description = "Resource Group ID where the budget is scoped"
  type        = string
}

variable "actual_thresholds" {
  description = "Actual cost alert thresholds as percentages"
  type        = list(number)
  default     = [50, 80]
}

variable "forecast_thresholds" {
  description = "Forecasted cost alert thresholds as percentages"
  type        = list(number)
  default     = [100]
}

variable "action_group_id" {
  description = "Azure Monitor Action Group ID"
  type        = string
}
