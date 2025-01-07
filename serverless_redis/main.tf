module "elasticache_serverless_cache" {
  source = "terraform-aws-modules/elasticache/aws//modules/serverless-cache"

  engine     = "redis"
  cache_name = var.cache_name

  cache_usage_limits = {
    data_storage = {
      maximum = var.max_storage_gb
    }
    ecpu_per_second = {
      maximum = var.max_ecpu
    }
  }

  daily_snapshot_time  = "22:00"
  description          = "Redis Serverless"
# kms_key_id           = aws_kms_key.this.arn
  major_engine_version = "7"

  security_group_ids = var.security_group_id

  snapshot_retention_limit = 7
  subnet_ids               = var.subnet_ids

#  user_group_id = module.cache_user_group.group_id

  tags = {
    Environment = "stage"
    Project = "litebox-internal"
  }
}