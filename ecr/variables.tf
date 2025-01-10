variable "repository_name" {
  type = string
  default = "api-wallet"
}

variable "principal_arns" {
  description = "List of ARNs for IAM roles or users that should have access to the ECR repository."
  type        = list(string)
}

variable "create_repository" {
  type = bool
  default = true
}