module "ecs-service" {
  source = "terraform-aws-modules/ecs/aws//modules/service"

  name        = var.name
  cluster_arn = var.cluster_arn
  
  cpu    = 2048
  memory = 4096

  create_task_exec_iam_role = var.create_task_exec_iam_role
  create_task_exec_policy = var.create_task_exec_policy
  create_tasks_iam_role = var.create_tasks_iam_role

  task_exec_iam_role_arn = var.task_role
  tasks_iam_role_arn = var.task_role

  container_definitions = merge (
    {
      (var.container_name) = {
        cpu       = var.cpu
        memory    = var.memory
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
        readonlyRootFilesystem = false
        secrets = [for name, arn in var.secrets : {
          name      = name
          valueFrom = arn
        }]
      }
    },
    var.nginxProxy == false
      ? {} 
      : {
          nginx = {
            cpu       = 512
            memory    = 1024
            essential = true
            image     = tostring(var.nginxImage)
            port_mappings = [
              {
                name          = "nginxport"
                containerPort = 80
                protocol      = "tcp"
              }
            ]
            readonly_root_filesystem = false
            dependencies = [{
              containerName = "${var.container_name}"
              condition     = "START"
            }]            
            memory_reservation       = 100
          }
        }    
  )
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
      discovery_name = "${var.name}-${var.apiPort}-http"
    }
  }

  load_balancer = {
    service = {
      target_group_arn = var.target_group_arn
      container_name   = var.nginxProxy ? "nginx" : var.container_name
      container_port   = var.nginxProxy ? 80 : var.apiPort
    }
  }  
}