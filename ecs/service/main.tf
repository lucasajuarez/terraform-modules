module "ecs-service" {
  source = "terraform-aws-modules/ecs/aws//modules/service"

  name        = var.name
  cluster_arn = var.cluster_arn
  
  cpu    = 1024
  memory = 4096

  create_task_exec_iam_role = var.create_task_exec_iam_role
  create_task_exec_policy = var.create_task_exec_policy
  create_tasks_iam_role = var.create_tasks_iam_role

  task_exec_iam_role_arn = var.task_role
  tasks_iam_role_arn = var.task_role

  container_definitions = {
    (var.container_name) = {
      cpu       = 512
      memory    = 1024
      essential = true
      image     = tostring(var.apiImage)
      port_mappings = [
        {
          name          = "apiport"
          containerPort = var.apiPort
          protocol      = "tcp"
        }
      ]
      memory_reservation = 50
    }
  }

  subnet_ids = var.subnet_ids

  security_group_rules = {
    alb_ingress_3000 = {
      type                     = "ingress"
      from_port                = 0
      to_port                  = 0
      protocol                 = "-1"
      cidr_blocks = ["0.0.0.0/0"]    }
    egress_all = {
      type        = "egress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  service_connect_configuration = {
    namespace = var.namespace
    service = {
      client_alias = {
        port     = var.apiPort
        dns_name = "${var.name}-${var.apiPort}.${var.namespace}"
      }
      port_name      = "apiport"
      discovery_name = "${var.name}-${var.apiPort}-tcp"
    }
  }

  load_balancer = {
    service = {
      target_group_arn = var.target_group_arn
      container_name   = var.container_name
      container_port   = var.apiPort
    }
  }  
}