module "alb" {
    source = "terraform-aws-modules/alb/aws"
    
    name    = var.alb_name
    vpc_id  = var.vpc_id
    subnets = var.lb_subnets
    internal = var.is_Internal
    load_balancer_type = var.load_balancer_type

    # Security Group
    security_group_ingress_rules = {
      all_http = {
        from_port   = 80
        to_port     = 80
        ip_protocol = "tcp"
        description = "HTTP web traffic"
        cidr_ipv4   = "0.0.0.0/0"
      } 
      all_https = {
        from_port   = 443
        to_port     = 443
        ip_protocol = "tcp"
        description = "HTTPS web traffic"
        cidr_ipv4   = "0.0.0.0/0"
      }
    }

    security_group_egress_rules = {
        all = {
            ip_protocol = "-1"
            cidr_ipv4   = "10.0.0.0/16"
        }
    }

    

################### commented in case of need to add redirect ##################
################### commented in case of need to add redirect ##################
################### commented in case of need to add redirect ##################

  listeners = {
    http-redirect = {
      port     = 80
      protocol = "HTTP"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        message_body = "Moved Permanently"
        status_code = "HTTP_301"
      }
    }
    http = {
      port            = 443 #TODO CAMBIAR A HTTPS CUANDO PUEDA TENER CERTIFICADO
      protocol        = "HTTPS"
      certificate_arn = var.certificate_arn
      fixed_response = {
        status_code  = "503"
        content_type = "text/plain"
        message_body = "Service Unavailable"
      }
      rules = {
        for tg_name in var.target_groups : tg_name => {
          priority = index(var.target_groups, tg_name) + 1
          actions = [{
            type             = "forward"
            target_group_key = tg_name
          }]
          conditions = [{
            host_header = {
              values = ["${tg_name}.${var.domain}"]
            }              
          }]
        }
      }
    }
  }
###################
###################
###################

  target_groups = {
    for tg_name in var.target_groups : tg_name => {
      name        = tg_name
      protocol    = "HTTP"
      port        = 80
      target_type = "ip"
      deregistration_delay = 10
      target_id   = var.target_id
      health_check = tg_name == "oauth2" || tg_name == "admin-sparkle" || tg_name == "slackbot-sparkle" || tg_name == "api-sparkle" ? {
        path                = "/ping"
        interval            = 5
        timeout             = 2
        healthy_threshold   = 2
        unhealthy_threshold = 2
        matcher             = "200"     
      } : null
    }
  }
}

