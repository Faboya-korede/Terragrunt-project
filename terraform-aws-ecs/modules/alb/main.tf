resource "random_pet" "this" {
  length = 2
}


# security group for load balancer
resource "aws_security_group" "lb" {
  name        = "${var.name}-${random_pet.this.id}"
  vpc_id      = var.vpc_id

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

   ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}


resource "aws_lb" "lb" {
  name            = "${var.name}-${random_pet.this.id}"
  subnets         =  var.public_subnets
  security_groups = [aws_security_group.lb.id]

  tags = var.tags
}

resource "aws_lb_target_group" "tg" {
  name        = "${var.name}-${random_pet.this.id}"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    path                = "/" 
    interval            = 100       
    timeout             = 90        
    healthy_threshold   = 2         
    unhealthy_threshold = 10        
    matcher             = "200-399" 
  }

  tags = var.tags

}



resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.lb.id
  port              = "80"
  protocol          = "HTTP"


  default_action {
    target_group_arn = aws_lb_target_group.tg.id
    type             = "forward"
  }

  tags = var.tags
}