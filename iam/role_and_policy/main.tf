module "ecs_execution_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"

  role_name = var.role_name
  create_role = true

  role_requires_mfa  = false

  create_custom_role_trust_policy = true

  custom_role_trust_policy = var.trust_policy

  trusted_role_services = [
    "ecs-tasks.amazonaws.com"
  ]

  custom_role_policy_arns = [
    module.iam_policy.arn
  ]

}


module "iam_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"

  name        = var.policy_name
  path        = "/"
  description = "task Execution Policy"
  policy = var.policy
}