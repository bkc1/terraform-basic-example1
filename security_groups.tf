## Security group for myapp  instances
resource "aws_security_group" "nodes" {
  name        = "${var.app_prefix}-${var.env}-instances"
  description = "${var.app_prefix} ${var.env} instances - Terraform managed"
  vpc_id      = aws_vpc.myapp.id
  tags = {
    Name = "${var.app_prefix}-${var.env}-instances"
  }

  # SSH access from internal
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.util_cidr]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.myapp.cidr_block]
  }

  # ICMP from the VPC & UTIL CIDR
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [aws_vpc.myapp.cidr_block, var.util_cidr]
  }

  # Nagios from UTIL CIDR & TUX DC
  ingress {
    from_port   = 5666
    to_port     = 5666
    protocol    = "tcp"
    cidr_blocks = [var.util_cidr]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

## A security group for the ELB so it is accessible via the web
resource "aws_security_group" "elb" {
  name        = "${var.app_prefix}-${var.env}-elb"
  description = "${var.app_prefix} ${var.env} ELB sec group - Terraform managed"
  vpc_id      = aws_vpc.myapp.id
  tags = {
    Name = "${var.app_prefix}-${var.env}-ELB"
  }

  # HTTPS access
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access. This gets redirected to SSL by apache
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

