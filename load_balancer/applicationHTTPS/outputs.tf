output "dns_name" {
 value = module.alb.dns_name
}

output "target_group_arn" {
    value = { for key, tg in aws_lb_target_group.this : key => tg.arn }
}