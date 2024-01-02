
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.nopvpc.id

  tags = {
    Name = "public-rt"
  }
  depends_on = [aws_subnet.nop-subnets]

}
resource "aws_route_table" "private-rt-1" {
  vpc_id = aws_vpc.nopvpc.id

  tags = {
    Name = "private-rt-1"
  }
  depends_on = [aws_subnet.nop-subnets]

}
resource "aws_route_table" "private-rt-2" {
  vpc_id = aws_vpc.nopvpc.id

  tags = {
    Name = "private-rt-2"
  }
  depends_on = [aws_subnet.nop-subnets]

}



resource "aws_route_table_association" "public-assoc-1" {
  route_table_id = aws_route_table.public-rt.id
  subnet_id      = aws_subnet.nop-subnets[0].id

}
resource "aws_route_table_association" "public-assoc-2" {
  route_table_id = aws_route_table.public-rt.id
  subnet_id      = aws_subnet.nop-subnets[1].id

}
resource "aws_route_table_association" "private-assoc-1" {
  route_table_id = aws_route_table.private-rt-1.id
  subnet_id      = aws_subnet.nop-subnets[2].id

}
resource "aws_route_table_association" "private-assoc-2" {
  route_table_id = aws_route_table.private-rt-1.id
  subnet_id      = aws_subnet.nop-subnets[3].id

}
resource "aws_route_table_association" "private-assoc-3" {
  route_table_id = aws_route_table.private-rt-2.id
  subnet_id      = aws_subnet.nop-subnets[4].id

}
resource "aws_route_table_association" "private-assoc-4" {
  route_table_id = aws_route_table.private-rt-2.id
  subnet_id      = aws_subnet.nop-subnets[5].id

}
resource "aws_route" "public-r" {
  route_table_id         = aws_route_table.public-rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.nop-igw.id

}
