dependency "vpc" {
  config_path = "../vpc"
}

dependency "ecs" {
  config_path = "../ecs"
}

inputs = {
  vpc_id        = dependency.vpc.outputs.vpc_id
  public_subnets = dependency.vpc.outputs.public_subnets
}