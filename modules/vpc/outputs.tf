output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "subnet_pub" {
  value = aws_subnet.public-subnet.*.id
}

output "subnet_pri" {
  value = aws_subnet.private-subnet.*.id
}

output "route_table_pub" {
  value = aws_route_table.public-rt.*.id
}

output "route_table_pri_dev" {
  value = aws_route_table.private-rt-optional.*.id
}

output "route_table_pri_manage" {
  value = aws_route_table.private-rt.*.id
}

output "route_table_pri_prod" {
  value = aws_route_table.private-rt-optional.*.id
}
