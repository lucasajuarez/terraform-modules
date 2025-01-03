provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "terrastate_bucket" {
  bucket = var.bucket-name
  force_destroy = false 
  object_lock_enabled = false
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.terrastate_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "remotestate_table" {
  name           = var.table_name
  hash_key       = "LockID"
  billing_mode   = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "${var.Environment}-Dynamo"
  }
}