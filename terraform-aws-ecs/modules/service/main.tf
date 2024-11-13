resource "random_pet" "that" {
  length = 2
}

# Security group for ecs fonu-abi
resource "aws_security_group" "task-sg" {
  name        = "${var.name}-task-sg"
  vpc_id      = var.vpc_id

  ingress {
    protocol        = "tcp"
    from_port       = 80
    to_port         = 80
    cidr_blocks     = ["0.0.0.0/0"]
   
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_ecs_service" "svc" {
  name            = var.name
  cluster         = var.cluster
  task_definition = var.task_definition_arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }


   network_configuration {
    security_groups = [aws_security_group.task-sg.id]
    subnets         = var.private_subnets
    assign_public_ip = true  
  }

}

