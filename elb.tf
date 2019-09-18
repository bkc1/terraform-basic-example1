resource "aws_elb" "web" {
  name                      = "${var.app_prefix}-${var.env}-elb"
  subnets                   = [aws_subnet.myapp1.id, aws_subnet.myapp2.id]
  security_groups           = [aws_security_group.elb.id]
  instances                 = [aws_instance.web1.id, aws_instance.web2.id]
  cross_zone_load_balancing = true
  connection_draining       = true
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
    #    lb_port            = 443
    #    lb_protocol        = "https"
    #    ssl_certificate_id = "${var.ssl_cert_id}"
  }
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
  tags = {
    Environment = "${var.app_prefix}-${var.env}"
  }
}

