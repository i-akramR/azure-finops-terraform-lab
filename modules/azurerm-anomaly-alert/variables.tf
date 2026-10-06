variable "name" {
  description = "Name of the cost anomaly alert."
  type        = string
}

variable "display_name" {
  description = "Display name of the cost anomaly alert."
  type        = string
}

variable "subscription_id" {
  description = "Azure subscription ID."
  type        = string
}

variable "email_subject" {
  description = "Email subject for anomaly alerts."
  type        = string
}

variable "email_addresses" {
  description = "Email addresses receiving anomaly alerts."
  type        = list(string)
}

variable "message" {
  description = "Message sent with anomaly alert."
  type        = string
}
