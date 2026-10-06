variable "storage_account_name" {
  description = "Existing Storage Account name"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group containing the existing Storage Account"
  type        = string
}

variable "container_name" {
  description = "Existing Blob container name"
  type        = string
}
variable "export_name" {
  description = "Cost Management Export name"
  type        = string
}

variable "start_date" {
  description = "Cost export start date in UTC"
  type        = string
}

variable "end_date" {
  description = "Cost export end date in UTC"
  type        = string
}

variable "root_folder_path" {
  description = "Root folder inside the storage container"
  type        = string
  default     = "/finops"
}
