# Output del ID de la VPC creada
output "cluster_arn" {
  value = module.ecs_cluster.arn
}

output "cluster_name" {
  value = module.ecs_cluster.name
}