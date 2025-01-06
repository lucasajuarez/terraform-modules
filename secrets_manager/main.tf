module "secrets_manager" {
  source = "terraform-aws-modules/secrets-manager/aws"

  # Secret metadata
  name_prefix             = var.name_prefix
  description             = var.description
  recovery_window_in_days = var.recovery_window_in_days

  # Secret value
  secret_string = jsonencode(var.secret_values)

  # Policy for accessing the secret
  create_policy       = true
  block_public_policy = true
  policy_statements = {
    ecs_service_access = {
      sid = "AllowECSServiceAccess"
      principals = [{
        type        = "AWS"
        identifiers = [var.ecs_service_role_arn]
      }]
      actions   = ["secretsmanager:GetSecretValue"]
      resources = ["${module.secrets_manager.secrets[0].arn}"]
    }
  }

  tags = var.tags
}
