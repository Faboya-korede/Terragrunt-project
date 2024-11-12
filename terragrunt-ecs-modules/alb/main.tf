module "alb" {
  source = "../../terraform-aws-ecs/modules/alb"
  name            = var.name
  host_name       = var.host_name
  domain_name     = var.domain_name
  certificate_arn = var.certificate_arn
  backend_sg_id   = var.backend_sg_id
  tags            = var.tags
  vpc_id          = var.vpc_id
  vpc_subnets     = var.vpc_subnets
}
