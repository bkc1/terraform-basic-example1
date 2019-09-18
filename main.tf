# Specify the provider and access details
provider "aws" {
  region = var.aws_region
  #  version = "~> 0.1"
}

resource "aws_key_pair" "auth" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

#data "terraform_remote_state" "myapp" {
#  backend = "s3"
#  config {
#    bucket = "myapp-${var.env}-tf-state-${var.aws_region}"
#    key    = "terraform-${var.env}.tfstate"
#    region = "${var.aws_region}"
#  }
#}
#
#data "aws_ami" "ecs_ami" {
#  most_recent = true
#  filter {
#    name   = "name"
#    values = ["amzn-ami-*"]
#  }
#  name_regex  = "\\S*ecs-optimized"
#  owners      = ["amazon"]
#}
