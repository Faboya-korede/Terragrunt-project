dependency "vpc" {
  config_path = "../vpc"
}

dependency "ecs" {
  config_path = "../ecs"
}

inputs = {
  backend_sg_id = dependency.ecs.outputs.instance_sg_id
  vpc_id        = dependency.vpc.outputs.vpc_id
  vpc_subnets   = dependency.vpc.outputs.vpc_subnets
}
