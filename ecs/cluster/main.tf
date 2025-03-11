module "ecs_cluster" {
  source = "terraform-aws-modules/ecs/aws//modules/cluster"

  cluster_name = var.cluster_name

  cluster_configuration = {
    execute_command_configuration = {
      logging = "OVERRIDE"
      log_configuration = {
        cloud_watch_log_group_name = "/aws/ecs/aws-ec2"
      }
    }
  }
  
  fargate_capacity_providers = {
    FARGATE = {
      default_capacity_provider_strategy = {
        weight = 100
      }
    }
  }

  tags = {
    #Environment = "Development"
    Environment     = "stage"
    Project         = "litebox-internal"
  }

}