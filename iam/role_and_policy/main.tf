module "ecs_execution_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"

  role_name = var.role_name
  create_role = true


  trusted_role_services = [
    "ecs-tasks.amazonaws.com"
  ]

  custom_role_policy_arns = [
    module.iam_policy.arn
  ]

  output "ecs_execution_role_arn" {
      description = "The ARN of the ECS execution role"
      value = module.ecs_execution_role.iam_role_arn
  }

}


module "iam_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"

  name        = var.policy_name
  path        = "/"
  description = "task Execution Policy"
  policy = var.policy
}