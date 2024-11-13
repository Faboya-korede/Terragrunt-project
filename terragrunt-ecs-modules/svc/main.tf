resource "aws_ecs_task_definition" "app" {
  family                = "${var.container_name}-${var.environment}"
  container_definitions = <<EOF
[
  {
    "name": "${var.container_name}",
    "image": "${var.container_image}",
    "essential": ${var.essential},
    "portMappings": [
      {
        "containerPort": ${var.container_port}
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${var.log_groups[0]}",
        "awslogs-region": "${var.region}"
      }
    },
    "memory": ${var.container_memory},
    "cpu": ${var.container_cpu}
  }
]
EOF
}

module "ecs_service_app" {
  source = "/Users/macbook/new/terraform-aws-ecs/modules/service"

  name = var.container_name

  #alb_target_group_arn = var.alb_target_group_arn
  cluster              = var.cluster
  container_name       = var.container_name
  container_port       = var.container_port
  log_groups           = var.log_groups
  task_definition_arn  = aws_ecs_task_definition.app.arn

  tags = var.tags
}
