variable "cache_name" {
  type = string
}

variable "max_storage_gb" {
  type = number
}

variable "max_ecpu" {
  type = number
}

variable "subnet_ids" {
  type = list(string)
}

variable "security_group_ids" {
  type = list(string)
}