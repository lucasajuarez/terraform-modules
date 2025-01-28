variable "s3_bucket_name" {
    description = "ARN del bucket S3"
    type        = string
    }

variable "s3_bucket_arn" {
    description = "ARN del bucket S3"
    type        = string
    }

variable "principal" {
    description = "AWS Principal"
    type        = string
    } 

variable "sparkle_role_principal" {
    description = "Sparkle Role AWS Principal"
    type        = string
    }            