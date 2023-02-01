output "ids" {
  description = "The IDs of subnets created"
  value       = aws_subnet.subnet.*.id
}
