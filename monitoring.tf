resource "aws_cloudwatch_metric_alarm" "web1-Status-Check-Any" {
  alarm_name          = "${var.app_prefix}-${var.env}-web1-Status-Check-Any"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "5"
  metric_name         = "StatusCheckFailed"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Maximum"
  threshold           = "1"
  dimensions = {
    InstanceId = aws_instance.web1.id
  }
  alarm_description = "Terraform-managed: This metric monitors ec2 instance & system status"
  #    alarm_actions             = ["${lookup(var.sns_topic_arn, var.aws_region)}"]
  #    insufficient_data_actions = []
  #    ok_actions                = ["${lookup(var.sns_topic_arn, var.aws_region)}"]
}

resource "aws_cloudwatch_metric_alarm" "web2-Status-Check-Any" {
  alarm_name          = "${var.app_prefix}-${var.env}-web2-Status-Check-Any"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "5"
  metric_name         = "StatusCheckFailed"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Maximum"
  threshold           = "1"
  dimensions = {
    InstanceId = aws_instance.web2.id
  }
  alarm_description = "Terraform-managed: This metric monitors ec2 instance & system status"
  #    alarm_actions             = ["${lookup(var.sns_topic_arn, var.aws_region)}"]
  #    insufficient_data_actions = []
  #    ok_actions                = ["${lookup(var.sns_topic_arn, var.aws_region)}"]
}

resource "aws_cloudwatch_metric_alarm" "web1-CPUUtilization" {
  alarm_name          = "${var.app_prefix}-${var.env}-web1-CPUUtilization"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "5"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "90"
  dimensions = {
    InstanceId = aws_instance.web1.id
  }
  alarm_description = "Terraform-managed: This metric monitors ec2 instance CPU utilization"
  #    alarm_actions             = ["${lookup(var.sns_topic_arn, var.aws_region)}"]
  #    insufficient_data_actions = []
  #    ok_actions                = ["${lookup(var.sns_topic_arn, var.aws_region)}"]
}

resource "aws_cloudwatch_metric_alarm" "web2-CPUUtilization" {
  alarm_name          = "${var.app_prefix}-${var.env}-web2-CPUUtilization"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "5"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "90"
  dimensions = {
    InstanceId = aws_instance.web2.id
  }
  alarm_description = "Terraform-managed: This metric monitors ec2 instance CPU utilization"
  #    alarm_actions             = ["${lookup(var.sns_topic_arn, var.aws_region)}"]
  #    insufficient_data_actions = []
  #    ok_actions                = ["${lookup(var.sns_topic_arn, var.aws_region)}"]
}

