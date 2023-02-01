output "id" {
  description = "The id of the NGW attached to VPC"
  value       = aws_nat_gateway.nat-gw.*.id
}

output "nat_ip" {
  description = "The public ip for the NGW attached to VPC"
  value       = aws_eip.nat_ip.*.public_ip
}