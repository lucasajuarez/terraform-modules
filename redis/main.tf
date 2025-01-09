module "elasticache" {
  source = "terraform-aws-modules/elasticache/aws"

  cluster_id               = "${var.environment}-${var.project_name}-${var.cluster_name}"
  create_cluster           = true
  create_replication_group = false

  engine_version = "7.1"
  node_type      = "cache.t4g.small"

  maintenance_window = "sun:05:00-sun:09:00"
  apply_immediately  = true
  transit_encryption_enabled = false
  at_rest_encryption_enabled = false
  az_mode = "single-az"
  num_cache_nodes = 1

  # Security group
  vpc_id = var.vpc_id
  security_group_rules = {
    ingress_vpc = {
      # Default type is `ingress`
      # Default port is based on the default engine port
      description = "Redis VPC Traffic"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }

  # Subnet Group
  subnet_ids = var.private_subnets

  # Parameter Group
  create_parameter_group = true
  parameter_group_family = "redis7"
  parameters = [
    {
      name  = "latency-tracking"
      value = "yes"
    }
  ]

  tags = {
    Environment = var.environment
    Project = var.project_name
  }
}