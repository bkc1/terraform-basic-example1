resource "aws_route53_zone" "myapp" {
  name    = "${var.domain_name}"
  vpc_id  = "${aws_vpc.myapp.id}"
  comment = "${var.app_prefix} - ${var.env} - ${var.aws_region} - Terraform Managed"
  tags {
    Environment = "${var.app_prefix}-${var.env}"
  }
}

resource "aws_route53_record" "web1" {
  zone_id = "${aws_route53_zone.myapp.zone_id}"
  name    = "${aws_instance.web1.tags.Name}"
  type    = "A"
  ttl     = "300"
  records = ["${aws_instance.web1.private_ip}"]
}

resource "aws_route53_record" "web2" {
  zone_id = "${aws_route53_zone.myapp.zone_id}"
  name    = "${aws_instance.web2.tags.Name}"
  type    = "A"
  ttl     = "300"
  records = ["${aws_instance.web2.private_ip}"]
}


