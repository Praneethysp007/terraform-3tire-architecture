resource "aws_db_subnet_group" "nop" {
  name       = "nop"
  subnet_ids = [aws_subnet.nop-subnets[4].id, aws_subnet.nop-subnets[5].id]

  tags = {
    Name = "My DB subnet group"
  }
  depends_on = [ aws_subnet.nop-subnets ]
}

resource "aws_db_instance" "default" {
  allocated_storage      = 20
  db_name                = "mydb"
  engine                 = "mysql"
  engine_version         = "8.0.35"
  instance_class         = "db.t3.micro"
  username               = "nopcommerce"
  password               = "nop12345"
  identifier             = "mynopdb"
  db_subnet_group_name   = aws_db_subnet_group.nop.name
  vpc_security_group_ids = [aws_security_group.dbsec.id]
  skip_final_snapshot    = true
}
resource "aws_db_instance" "default1" {
  allocated_storage      = 20
  db_name                = "mydb"
  engine                 = "mysql"
  engine_version         = "8.0.35"
  instance_class         = "db.t3.micro"
  username               = "nopcommerce"
  password               = "nop12345"
  identifier             = "mynopdb"
  availability_zone =     "us-east-2b"
  db_subnet_group_name   = aws_db_subnet_group.nop.name
  vpc_security_group_ids = [aws_security_group.dbsec.id]
  skip_final_snapshot    = true
}