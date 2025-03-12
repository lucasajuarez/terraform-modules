variable "s3_bucket_name" {
    description = "ARN del bucket S3"
    type        = string
    }

variable "s3_bucket_arn" {
    description = "ARN del bucket S3"
    type        = string
    }

variable "ecs_role_arn" {
    description = "AWS ECS Role Principal"
    type        = string
    }  

variable "sparkle_s3_user_arn" {
    description = "Sparkle Role AWS Principal"
    type        = string
    }     