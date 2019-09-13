output "vpc_id"                   { value = "${aws_vpc.myapp.id}"}
output "vpc_main_route_table_id"  { value = "${aws_vpc.myapp.main_route_table_id}"}
output "vpc_cidr_block"           { value = "${aws_vpc.myapp.cidr_block}"}
output "sg_node_id"           { value = "${aws_security_group.nodes.id}"}
