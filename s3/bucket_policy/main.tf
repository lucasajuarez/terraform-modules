resource "aws_s3_bucket_policy" "policy" {
    bucket = var.s3_bucket_name
    policy = jsonencode({
        "Version": "2012-10-17",
        "Statement": [
            {
                "Sid": "PublicRead",
                "Effect": "Allow",
                "Principal": "*",
                "Action": [
                    "s3:PutObject",
                    "s3:PutObjectAcl"
                ],
                "Resource": "${var.s3_bucket_arn}/*",
                "Condition": {
                    "StringEquals": {
                        "s3:x-amz-acl": "public-read"
                    }
                }
            }
        ]
    })    
}


# output "s3_bucket_name" {
#     description = "Nombre del bucket S3."
#     value       = aws_s3_bucket.my_bucket.bucket
# }

# output "s3_bucket_arn" {
#     description = "ARN del bucket S3."
#     value       = aws_s3_bucket.my_bucket.arn
# }

# output "cloudfront_distribution_arn" {
#     description = "ARN de la distribución de CloudFront asociada."
#     value       = aws_cloudfront_distribution.my_distribution.arn
# }

# output "s3_bucket_domain_name" {
#     description = "Nombre de dominio del bucket S3."
#     value       = aws_s3_bucket.my_bucket.bucket_domain_name
# }

