module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = var.bucket_name
  acl    = "private"
  block_public_acls = false
  block_public_policy     = false
  restrict_public_buckets = false

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    enabled = false
  }

  tags = {
    Terraform   = "true"
  }

}