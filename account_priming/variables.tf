variable "region" {
  type        = string
  default     = "us-east-1"
  description = "Region"
}
variable "bucket-name" {
  type        = string
  default = "terrastate-bucket"
  description = "S3 bucket name"
}

variable "Environment" {
  type = string
  default = "dev"
}

variable "table_name" {
  type = string
  default = "terraform-lock-table"
}