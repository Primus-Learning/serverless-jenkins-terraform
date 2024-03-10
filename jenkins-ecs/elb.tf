# ALB
resource "aws_lb" "alb" {
  name               = "${var.prefix}-alb"
  internal           = false
  load_balancer_type = "application"
  # Attaching the jenkins-alb security group
  security_groups = [aws_security_group.jenkins_alb.id]
  # Placing the ALB in all the public subnets
  subnets = var.public_subnets

  tags = {
    Name = "${var.prefix}-alb"
  }
}

# load balancer target group
resource "aws_lb_target_group" "tg" {
  name        = "${var.prefix}-tg"
  target_type = "ip"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id

  # Health check specified to /login
  health_check {
    enabled  = true
    path     = "/login"
    interval = 300
  }

  tags = {
    Name = "${var.prefix}-tg"
  }
}

# ALB Listener
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}