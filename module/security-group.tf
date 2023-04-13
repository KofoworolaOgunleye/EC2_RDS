resource "aws_security_group" "allow_80_from_internet" {
  name        = "${var.env_name}-alb-security-group"
  vpc_id      = aws_vpc.main.id
  description = "Application Load Balancer (ALB) access"

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "allow_80_from_lb" {
  name        = "${var.env_name}-ec2-security-group"
  vpc_id      = aws_vpc.main.id
  description = "Allow ingress access from the ALB only"

  ingress {
    protocol  = "tcp"
    from_port = 80
    to_port   = 80
    # cidr_blocks     = ["0.0.0.0/0"]
    security_groups = [aws_security_group.allow_80_from_internet.id]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group" "allow_3306_from_ec2" {
  name        = "${var.env_name}-db-security-group"
  vpc_id      = aws_vpc.main.id
  description = "Allow ingress access from the EC2 only"

  ingress {
    protocol  = "tcp"
    from_port = 3306
    to_port   = 3306
    # cidr_blocks     = ["0.0.0.0/0"]
    security_groups = [aws_security_group.allow_80_from_lb.id]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

}

