module "ecs_cluster" {
  source = "../../terraform-aws-ecs/modules/cluster"

  asg_min_size = var.asg_min_size
  asg_max_size = var.asg_max_size
  name         = var.name
  vpc_id       = var.vpc_id
  vpc_subnets  = var.vpc_subnets
  tags         = var.tags
}
