dependency "vpc" {
  config_path = "../vpc"
}

inputs = {
  vpc_id      = dependency.vpc.outputs.vpc_id
  vpc_subnets = dependency.vpc.outputs.vpc_subnets
}
