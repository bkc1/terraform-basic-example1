# Web instance in myapp1 subnet/AZ
resource "aws_instance" "web1" {
  connection {
    host = coalesce(self.public_ip, self.private_ip)
    type = "ssh"
    user = "centos"
  }
  tags = {
    Name = "${var.app_prefix}-${var.env}-web1-cloud"
  }
  instance_type          = "t2.medium"
  ami                    = var.aws_amis[var.aws_region]
  key_name               = aws_key_pair.auth.id
  vpc_security_group_ids = [aws_security_group.nodes.id]
  subnet_id              = aws_subnet.myapp1.id
  iam_instance_profile   = aws_iam_instance_profile.myapp.name

  #  user_data               = "${file("${var.cloud_init}")}"
  #  depends_on              = ["aws_instance.db"]
  root_block_device {
    delete_on_termination = true
    volume_type           = "standard"
  }
}

# Web instance in myapp2 subnet/AZ
resource "aws_instance" "web2" {
  connection {
    host = coalesce(self.public_ip, self.private_ip)
    type = "ssh"
    user = "centos"
  }
  tags = {
    Name = "${var.app_prefix}-${var.env}-web2-cloud"
  }
  instance_type          = "t2.medium"
  ami                    = var.aws_amis[var.aws_region]
  key_name               = aws_key_pair.auth.id
  vpc_security_group_ids = [aws_security_group.nodes.id]
  subnet_id              = aws_subnet.myapp2.id
  iam_instance_profile   = aws_iam_instance_profile.myapp.name

  #  user_data               = "${file("${var.cloud_init}")}"
  #  depends_on              = ["aws_instance.db"]
  root_block_device {
    delete_on_termination = true
    volume_type           = "standard"
  }
}

# Autoscale Group
resource "aws_launch_configuration" "myapp" {
  name_prefix          = "${var.app_prefix}-${var.env}"
  image_id             = var.aws_amis[var.aws_region]
  instance_type        = "t2.micro"
  enable_monitoring    = true
  key_name             = aws_key_pair.auth.id
  security_groups      = [aws_security_group.nodes.id]
  iam_instance_profile = aws_iam_instance_profile.myapp.name
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "myapp" {
  name_prefix          = "${var.app_prefix}-${var.env}"
  launch_configuration = aws_launch_configuration.myapp.name
  min_size             = 2
  max_size             = 4
  desired_capacity     = 2
  enabled_metrics = [
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupMaxSize",
    "GroupMinSize",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances",
  ]
  vpc_zone_identifier = [aws_subnet.myapp2.id, aws_subnet.myapp2.id]
  lifecycle {
    create_before_destroy = true
  }
  tag {
    key                 = "Name"
    value               = "${var.app_prefix}-${var.env}-myapp"
    propagate_at_launch = true
  }
}

