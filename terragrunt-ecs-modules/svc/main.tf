resource "random_pet" "tham" {
  length = 2
}


#Iam role fo ecs
resource "aws_iam_role" "svc" {
  name = "${var.name}-${random_pet.tham.id}"
 
  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "ecs-tasks.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}


resource "aws_iam_role_policy_attachment" "svc" {
  role       = aws_iam_role.svc.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_cloudwatch_policy" {
  role       = aws_iam_role.svc.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}


# Create an ECS task fonu api
resource "aws_ecs_task_definition" "app" {
  family = "api"
  
  container_definitions = jsonencode([
    {
      "name": "${var.container_name}",
      "image" = "${var.container_image}",
      "cpu" = 0,
      "essential" = true,
      "portMappings" = [
        {
          "containerPort" = 80,
          "hostPort" = 80
        }
      ],
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-create-group": "true",
          "awslogs-group": "/app",
          "awslogs-region": "us-east-1"
          "awslogs-stream-prefix": "ecs"
        }
      }
    }
  ])
  
  task_role_arn         = aws_iam_role.svc.arn
  execution_role_arn    = aws_iam_role.svc.arn

  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.container_cpu
  memory                   = var.container_memory
}

module "ecs_service_app" {
  source = "/Users/macbook/new/terraform-aws-ecs/modules/service"

  name = var.container_name

  target_group_arn     = var.target_group_arn
  vpc_id               = var.vpc_id
  cluster              = var.cluster
  container_name       = var.container_name
  container_port       = var.container_port
  task_definition_arn  = aws_ecs_task_definition.app.arn
  private_subnets      = var.private_subnets

  tags = var.tags
}
