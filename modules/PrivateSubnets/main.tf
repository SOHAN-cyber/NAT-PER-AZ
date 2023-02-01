resource "aws_subnet" "subnet" {
  count             = length(var.subnets_cidr)
  availability_zone = element(var.availability_zones, count.index)
  cidr_block        = element(var.subnets_cidr, count.index)
  vpc_id            = var.vpc_id
  tags = merge(
    {
      Name = element(var.pvt_subnet_name, count.index)
    },
    var.tags,
  )
}

resource "aws_route_table_association" "route_table_association" {
  count          = length(aws_subnet.subnet.*.id)
  subnet_id      = aws_subnet.subnet[count.index].id
  route_table_id = element(var.route_table_id, count.index)
}