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
  major_engine_version = "7"

  snapshot_retention_limit = 7
  subnet_ids               = var.subnet_ids

  tags = {
    Environment = "stage"
    Project = "litebox-internal"
  }
}