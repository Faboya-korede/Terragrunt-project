variable "vpc_id" {
type = string
}

variable "private_subnets" {
  type = list(string)
  
}

variable "cluster" {
  description = "Name of the ECS cluster to create service in"
}

variable "target_group_arn" {
  description = "ARN of the ALB target group that should be associated with the ECS service"
}

variable "container_name" {
  description = "Name of the container that will be attached to the ALB"
}

variable "container_port" {
  description = "port the container is listening on"
  default     = 80
}



variable "desired_count" {
  description = "Desired count of the ECS task"
  default     = 1
}


variable "name" {
  description = "Name of the ecs service"
  default     = "svc"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
}

variable "task_definition_arn" {
  description = "ARN of the task defintion for the ECS service"
}

