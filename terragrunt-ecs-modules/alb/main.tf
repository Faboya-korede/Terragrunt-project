module "alb" {
  source = "/Users/macbook/new/terraform-aws-ecs/modules/alb"

  name            = var.name
  tags            = var.tags
  vpc_id          = var.vpc_id
  public_subnets  = var.public_subnets
}