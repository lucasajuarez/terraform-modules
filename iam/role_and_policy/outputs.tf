output "ecs_execution_role_arn" {
  description = "The ARN of the ECS execution role"
  value       = module.ecs_execution_role.iam_role_arn
}