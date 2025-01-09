output "dns_name" {
 value = module.alb.dns_name
}

output "target_group_arns" {
  value = [for tg in module.alb.target_groups : tg["arn"]]
  description = "List of ARNs for the dynamically created Target Groups"
}