resource "aws_route_table" "private-1a" {
  vpc_id = aws_vpc.taxapp.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.az-1a.id
  }

  tags = {
    Name = "rt-private-1a"
  }
}

resource "aws_route_table" "private-1b" {
  vpc_id = aws_vpc.taxapp.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.az-1b.id
  }

  tags = {
    Name = "rt-private-1b"
  }
}

resource "aws_route_table" "private-1c" {
  vpc_id = aws_vpc.taxapp.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.az-1c.id
  }

  tags = {
    Name = "rt-private-1c"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.taxapp.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.taxapp.id
  }

  tags = {
    Name = "rt-public"
  }
}

resource "aws_route_table_association" "api-private-1a" {
  subnet_id      = aws_subnet.api-private-1a.id
  route_table_id = aws_route_table.private-1a.id
}

resource "aws_route_table_association" "api-private-1b" {
  subnet_id      = aws_subnet.api-private-1b.id
  route_table_id = aws_route_table.private-1b.id
}

resource "aws_route_table_association" "api-private-1c" {
  subnet_id      = aws_subnet.api-private-1c.id
  route_table_id = aws_route_table.private-1c.id
}

### PUBLIC
resource "aws_route_table_association" "public-1a" {
  subnet_id      = aws_subnet.public-1a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public-1b" {
  subnet_id      = aws_subnet.public-1b.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public-1c" {
  subnet_id      = aws_subnet.public-1c.id
  route_table_id = aws_route_table.public.id
}

###DB
resource "aws_route_table_association" "db-private-1a" {
  subnet_id      = aws_subnet.db-private-1a.id
  route_table_id = aws_route_table.private-1a.id
}

resource "aws_route_table_association" "db-private-1b" {
  subnet_id      = aws_subnet.db-private-1b.id
  route_table_id = aws_route_table.private-1b.id
}

resource "aws_route_table_association" "db-private-1c" {
  subnet_id      = aws_subnet.db-private-1c.id
  route_table_id = aws_route_table.private-1c.id
}