output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets
}

output "public_subnets" {
  description = "List of public subnet"
  value = module.vpc.public_subnets 
}

output "prod_subnets" {
value = local.subnets
}

output "non_prod_subnets" {
  value = local.non_prod_subnets
}