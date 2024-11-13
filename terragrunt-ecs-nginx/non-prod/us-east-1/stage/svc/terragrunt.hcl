locals {
  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  region_vars      = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  account_vars     = read_terragrunt_config(find_in_parent_folders("account.hcl"))

  # Extract out common variables for reuse
  env             = local.environment_vars.locals.environment
  owner           = local.account_vars.locals.owner
  region          = local.region_vars.locals.region
  container_name  = "nginx"
  container_image = "nginx:1.18-alpine"
}

# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "../../../../../terragrunt-ecs-modules/svc"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

dependency "alb" {
  config_path = "../alb"
  mock_outputs = {
    listener_https_arn = "arn:aws:elasticloadbalancing:us-east-1:067653612345:listener/app/app-qa-aware-joey/8c1c7d99b5559a27/36cf5276bff3160d"
    target_group_arn   = "arn:aws:elasticloadbalancing:us-east-1:067653612345:targetgroup/h120200525224707917000000003/e34d2a0306ff19df"
  }
}

dependency "vpc" {
  config_path = "../vpc"
  mock_outputs = {
    vpc_id = "vpc-012341a0dd8b01234",
    private_subnets = [
      "subnet-003601fe683fd1111",
      "subnet-0f0787cffc6ae1112",
      "subnet-00e05034aa90b1112"
    ],
    public_subnets = [
        "subnet-003601fe683fd1114",
      "subnet-0f0787cffc6ae1114",
      "subnet-00e05034aa90b1114"
    ]
  }
}


dependency "ecs" {
  config_path = "../ecs"
  mock_outputs = {
    cluster_id     = "arn:aws:ecs:us-east-1:067653612345:cluster/app-qa"
    instance_role  = "app-qa-instance-role"
    instance_sg_id = "sg-05d46f4416d012345"
  }
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  version = "~> 1.0.9"

  name                 = "app-${local.env}"
  cluster              = dependency.ecs.outputs.cluster_id
  essential            = true
  region               = "${local.region}"
  container_name       = "${local.container_name}"
  container_image      = "${local.container_image}"
  container_port       = "80"
  log_groups           = ["app-${local.env}-${local.container_name}"]
  target_group_arn     = dependency.alb.outputs.target_group_arn
  vpc_id             = dependency.vpc.outputs.vpc_id
  private_subnets  = dependency.vpc.outputs.private_subnets
  tags = {
    Environment = "${local.env}"
    Owner       = "${local.owner}"
  }
}
