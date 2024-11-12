variable "module_version" {
  description = "Version of the terraform module"
  type        = string
  default     = "1.0.9"
}

variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = ""
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "domain_name" {
  description = "Domain name of a private Route 53 zone to create DNS record in"
}

variable "host_name" {
  description = "Optional hostname that will be used to created a sub-domain in Route 53. If left blank then a record will be created for the root domain (ex. example.com)"
  default     = ""
}

variable "backend_sg_id" {
  description = "Security group ID of the instance to add rule to allow incoming tcp from ALB"
}

variable "certificate_arn" {
  description = "ARN for SSL/TLS certificate"
  default     = "cert_arn"
}



variable "vpc_id" {
  description = "VPC ID to create cluster in"
}

variable "vpc_subnets" {
  description = "List of VPC subnets to put instances in"
  type        = list(string)
}
