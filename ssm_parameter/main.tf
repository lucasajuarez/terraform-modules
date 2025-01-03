module "multiple" {
  source  = "terraform-aws-modules/ssm-parameter/aws"

  for_each = var.parameters


  name            = try(each.value.name, each.key)
  value           = try(each.value.value, null)
  type            = try(each.value.type, null)
}

output "ssm_param_arns" {
  value = values({ for k, v in module.multiple : k => v.ssm_parameter_arn })
}