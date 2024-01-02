resource "aws_eip" "eip-1" {
  domain = "vpc"

}
resource "aws_eip" "eip-2" {
  domain = "vpc"

}
resource "aws_nat_gateway" "nat-1" {
  allocation_id = aws_eip.eip-1.id
  subnet_id     = aws_subnet.nop-subnets[0].id

  depends_on = [aws_eip.eip-1]

}


resource "aws_nat_gateway" "nat-2" {
  allocation_id = aws_eip.eip-2.id
  subnet_id     = aws_subnet.nop-subnets[1].id

  depends_on = [aws_eip.eip-2]
}

resource "aws_route" "nat-route-1" {
  route_table_id         = aws_route_table.private-rt-1.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat-1.id

}
resource "aws_route" "nat-route-2" {
  route_table_id         = aws_route_table.private-rt-2.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat-2.id

}
