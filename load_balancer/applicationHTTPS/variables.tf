variable "alb_name" {
    description = "Load Balancer name"
    type        = string
}

variable "vpc_id" {
    description = "VPC id where the LB will be created"
    type        = string
}

variable "lb_subnets" {
    description = "subnets associated with the LB"
    type        = list(string)
}

variable "target_groups" {
  type        = list(string)
  description = "List of target group names to create"
}

variable "certificate_arn" {
  type = string
}

variable "target_id" {
  type = string
}

variable "is_Internal" {
  type = string
  default = false
}

variable "load_balancer_type" {
  type = string
  default = "application"
}

variable "domain" {
  type = string
}
