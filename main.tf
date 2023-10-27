locals {
  vpc_id              = "vpc-04340d989c65bae41"
  private_a_subnet_id = "subnet-003974491b1706a82"
  private_b_subnet_id = "subnet-02e0662249e5d7bac"
  public_a_subnet_id  = "subnet-01705d249b9c4ec21"
  public_b_subnet_id  = "subnet-005174cd468bff185"

  ubuntu_ami = "ami-04b9aed6729a80c61"

  traffic_dist_map = {
    blue = {
      blue  = 100
      green = 0
    }
    blue-80 = {
      blue  = 80
      green = 20
    }
    split = {
      blue  = 50
      green = 50
    }
    green-80 = {
      blue  = 20
      green = 80
    }
    green = {
      blue  = 0
      green = 100
    }
  }
}


# Security Group
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
resource "aws_security_group" "web" {
  name        = "web-sg"
  description = "Security group for web-servers with HTTP ports open within VPC"
  vpc_id      = local.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

# Application Load Balancer
# At least two subnets in two different Availability Zones must be specified
# aws_lb: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb
resource "aws_lb" "app" {
  name               = "app-lb"
  internal           = false
  load_balancer_type = "application"
  subnets = [
    local.public_a_subnet_id,
    local.public_b_subnet_id
  ]
  security_groups = [aws_security_group.web.id]
}

# Load Balancer Listener
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener
resource "aws_lb_listener" "app" {
  load_balancer_arn = aws_lb.app.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "forward"
    # target_group_arn = aws_lb_target_group.blue.arn
    forward {
      target_group {
        arn    = aws_lb_target_group.blue.arn
        weight = lookup(local.traffic_dist_map[var.traffic_distribution], "blue", 100)
      }

      target_group {
        arn    = aws_lb_target_group.green.arn
        weight = lookup(local.traffic_dist_map[var.traffic_distribution], "green", 0)
      }

      stickiness {
        enabled  = false
        duration = 1
      }
    }
  }
}
