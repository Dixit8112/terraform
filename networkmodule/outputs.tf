output "vpc_id" {
  value = aws_vpc.main.id
}
output "vpc_cidr" {
  value = aws_vpc.main.cidr_block
}
output "natgw_id" {
  value = aws_nat_gateway.natgw.id
}
output "internetgw_id" {
  value = aws_internet_gateway.igw.id
}

output "publicsubnet_1_id" {
  value = aws_subnet.publicsubnet_1.id
}

output "publicsubnet_2_id" {
  value = aws_subnet.publicsubnet_2.id
}

output "privatesubnet_1_id" {
  value = aws_subnet.privatesubnet_1.id
}

output "privatesubnet_2_id" {
  value = aws_subnet.privatesubnet_2.id
}

output "bastion_sg_id" {
  value = aws_security_group.bastion_sg.id
}

output "private_sg_id" {
  value = aws_security_group.private_sg.id
}

output "public_route_table_id" {
  value = aws_route_table.public.id
}

output "private_route_table_id" {
  value = aws_route_table.private.id
}




