output "dns_name" {
 value = module.alb.dns_name
}

output "target_group_arns" {
  #value = [for tg in module.alb.target_groups : tg["arn"]]
  value = { for tg in module.alb.target_groups : tg["name"] => tg["arn"] }
  description = "List of ARNs for the dynamically created Target Groups"
}

output "oauth2_arn" {
    value = output.target_group_arns["oauth2"]
}