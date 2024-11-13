dependency "ecs" {
  config_path = "../ecs"
}

dependency "alb" {
  config_path = "../ecs"
}

inputs = {
  target_group_arn = dependency.alb.outputs.target_group_arn
  cluster              = dependency.ecs.outputs.cluster_id
  vpc_id       = dependency.vpc.outputs.vpc_id
}
