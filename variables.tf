
variable "public_key_path" {
  description = "Enter path to the public key"
  default     = "keys/mykey.pub"
}

variable "key_name" {
  description = "Enter name of private key"
  default     = "mykey"
}

variable "aws_region" {
  description = "AWS region to launch servers"
  default     = "us-west-2"
}

variable "app_prefix" {
  description = "Application abbreviation/prefix"
  default     = "app1"
}

variable "az" {
  description = "Availability Zones per region"
  default = {
    us-east-1 = "us-east-1a,us-east-1c,us-east-1d,us-east-1e"
    us-west-1 = "us-west-1b,us-west-1c"
    us-west-2 = "us-west-2a,us-west-2b,us-west-2c"
  }
}

# CentOS 7 (x86_64) - with Updates HVM
variable "aws_amis" {
  description = "CentOS7 (x86_64)"
  default = {
    eu-west-1 = ""
    us-east-1 = "ami-ae7bfdb8"
    us-west-1 = "ami-7c280d1c"
    us-west-2 = "ami-0c2aba6c"
  }
}

##user-data cloud-init script
#variable "cloud_init" {
#}

# SNS topics for monitoring/alerting
#variable "sns_topic_arn" {
#  default = {
#    us-east-1 = "arn:aws:sns:us-east-1:XXXXXXXXXXXX:....."
#    us-west-1 = "arn:aws:sns:us-west-1:XXXXXXXXXXXX:....."
#    us-west-2 = "arn:aws:sns:us-west-2:XXXXXXXXXXXX:....."
#  }
#}

#Util Bastion Subnets
variable "util_cidr" {
  default = "10.3.1.0/24"
}

variable "env" { 
  default = "dev"
}

variable "domain_name" { 
  default = "aws-dev.example.io"
}

variable "vpc_cidr_block" { 
  default = "10.0.0.0/21"
}

variable "subnet1" { 
  default = "10.0.1.0/24"
}

variable "subnet2" { 
  default = "10.0.2.0/24"
}

