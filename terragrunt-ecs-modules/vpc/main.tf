module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.15.0"

  name               = var.name
  cidr               = var.cidr
  azs                = var.azs
  private_subnets    = var.private_subnets
  public_subnets     = var.public_subnets
  enable_nat_gateway = var.enable_nat_gateway
  single_nat_gateway = var.single_nat_gateway
  tags               = var.tags
}

locals {
  subnets = [
    "subnet-1233444",
    "subnet-2883833933",
    "subnet-9838388383"
  ]
}

locals {
  non_prod_subnets = [
    "subnet-1233444838",
    "subnet-2883833933",
    "subnet-9838388383"
  ]
}
