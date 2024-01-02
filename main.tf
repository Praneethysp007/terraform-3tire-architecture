resource "aws_vpc" "nopvpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "nop-vpc"
  }
}

resource "aws_internet_gateway" "nop-igw" {
  vpc_id = aws_vpc.nopvpc.id

  tags = {
    Name = "nop-igw"
  }
  depends_on = [aws_vpc.nopvpc]
}


resource "aws_subnet" "nop-subnets" {
  count                   = length(var.subnet-names)
  vpc_id                  = aws_vpc.nopvpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index)
  availability_zone       = var.az[count.index]
  map_public_ip_on_launch = var.public-ip[count.index]

  tags = {
    Name = var.subnet-names[count.index]
  }
  depends_on = [aws_internet_gateway.nop-igw]

}
resource "aws_security_group" "app-sg" {
  name        = var.spc-sg-rules.name
  description = var.spc-sg-rules.description
  vpc_id      = aws_vpc.nopvpc.id

  tags = {
    Name = "spc-sg"
  }
  depends_on = [aws_vpc.nopvpc]
}

resource "aws_security_group_rule" "sprules" {
  count             = length(var.spc-sg-rules.rules)
  type              = var.spc-sg-rules.rules[count.index].type
  from_port         = var.spc-sg-rules.rules[count.index].from_port
  to_port           = var.spc-sg-rules.rules[count.index].to_port
  protocol          = var.spc-sg-rules.rules[count.index].protocol
  cidr_blocks       = [var.spc-sg-rules.rules[count.index].cidr_blocks]
  security_group_id = aws_security_group.app-sg.id

}


resource "aws_security_group" "dbsec" {
  name        = var.dbsecurityrule.name
  description = var.dbsecurityrule.description
  vpc_id      = aws_vpc.nopvpc.id

  depends_on = [aws_vpc.nopvpc]
}


resource "aws_security_group_rule" "dbsecrule" {
  count             = length(var.dbsecurityrule.rules)
  type              = var.dbsecurityrule.rules[count.index].type
  from_port         = var.dbsecurityrule.rules[count.index].from_port
  to_port           = var.dbsecurityrule.rules[count.index].to_port
  protocol          = var.dbsecurityrule.rules[count.index].protocol
  cidr_blocks       = [var.dbsecurityrule.rules[count.index].cidr_blocks]
  security_group_id = aws_security_group.dbsec.id
}
resource "aws_security_group" "lb-sg" {
  name        = var.loadsecurityrule.name
  description = var.loadsecurityrule.description
  vpc_id      = aws_vpc.nopvpc.id

  tags = {
    Name = "spc-sg"
  }
  depends_on = [aws_vpc.nopvpc]
}

resource "aws_security_group_rule" "lbrules" {
  count             = length(var.loadsecurityrule.rules)
  type              = var.loadsecurityrule.rules[count.index].type
  from_port         = var.loadsecurityrule.rules[count.index].from_port
  to_port           = var.loadsecurityrule.rules[count.index].to_port
  protocol          = var.loadsecurityrule.rules[count.index].protocol
  cidr_blocks       = [var.loadsecurityrule.rules[count.index].cidr_blocks]
  security_group_id = aws_security_group.lb-sg.id

}
