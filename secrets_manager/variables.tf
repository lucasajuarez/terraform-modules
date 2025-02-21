variable "name" {
  description = "Prefix for the secret name"
  type        = string
}

variable "description" {
  description = "Description for the secret"
  type        = string
}

variable "recovery_window_in_days" {
  description = "Number of days to retain the secret after deletion"
  type        = number
  default     = 30
}

variable "secret_values" {
  description = "Key-value pairs to store in the secret"
  type        = map(string)
}

variable "ecs_service_role_arn" {
  description = "ARN of the ECS IAM role that needs access to the secret"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the secret"
  type        = map(string)
  default     = {}
}
