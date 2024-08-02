provider "aws" {
  region = "us-west-2"
}

# resource "aws_instance" "app_server" {
#   ami           = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI
#   instance_type = "t2.micro"

#   tags = {
#     Name = "AppServer"
#   }
# }

#   user_data = <<-EOF
#               #!/bin/bash
#               yum update -y
#               yum install -y docker
#               service docker start
#               usermod -a -G docker ec2-user
#               curl -sL https://rpm.nodesource.com/setup_14.x | bash -
#               yum install -y nodejs
#               git clone https://github.com/your-repo/quest.git /home/ec2-user/quest
#               cd /home/ec2-user/quest
#               docker build -t quest-app .
#               docker run -d -p 80:3000 --name quest-app quest-app
#               EOF
# }

resource "aws_security_group" "app_sg" {
  name_prefix = "app_sg_"

  ingress {
    from_port   = [443,80]
    to_port     = [80,443]
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "app_server" {
  ami           = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI
  instance_type = "t2.micro"
  security_groups = [aws_security_group.app_sg.name]

  tags = {
    Name = "AppServer"
  }
}

#   user_data = <<-EOF
#               #!/bin/bash
#               yum update -y
#               yum install -y docker
#               service docker start
#               usermod -a -G docker ec2-user
#               curl -sL https://rpm.nodesource.com/setup_14.x | bash -
#               yum install -y nodejs
#               git clone https://github.com/your-repo/quest.git /home/ec2-user/quest
#               cd /home/ec2-user/quest
#               docker build -t quest-app .
#               docker run -d -p 80:3000 --name quest-app quest-app
#               EOF
# }

resource "aws_lb" "app_lb" {
  name               = "app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.app_sg.id]
  subnets            = ["subnet-0123456789abcdef0"] # Replace with your subnet ID

  enable_deletion_protection = false
}

resource "aws_lb_target_group" "app_tg" {
  name     = "app-tg"
  port     = [80,443]
  protocol = ["HTTP","HTTPS"]
  vpc_id   = "vpc-0123456789abcdef0" # Replace with your VPC ID

  health_check {
    path = "/"
    port = "traffic-port"
    protocol = ["HTTP","HTTPS"]
  }
}

resource "aws_lb_listener" "app_listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = [80,443]
  protocol          = ["HTTP","HTTPS"]

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}

resource "aws_lb_target_group_attachment" "app_attachment" {
  target_group_arn = aws_lb_target_group.app_tg.arn
  target_id        = aws_instance.app_server.id
  port             = [80,443]
}
