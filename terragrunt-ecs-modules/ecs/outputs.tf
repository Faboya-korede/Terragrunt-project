output "cluster_id" {
  value = module.ecs_cluster.cluster_id
}

output "instance_sg_id" {
  value = module.ecs_cluster.instance_sg_id
}

output "instance_role" {
  value = module.ecs_cluster.instance_role
}
