resource "aws_eip" "nat_ip" {
  count = var.single_nat_gateway ? 1 : length(var.subnets_for_nat_gw)
  vpc   = true
}

resource "aws_nat_gateway" "nat-gw" {
  count         = var.single_nat_gateway ? 1 : length(var.subnets_for_nat_gw)
  allocation_id = aws_eip.nat_ip[count.index].id
  subnet_id     = var.subnets_for_nat_gw[count.index]
  tags = merge(
    {
      Name = element(var.nat_gateway_name, count.index)
    },
    var.tags,
  )
}