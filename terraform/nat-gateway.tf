resource "aws_eip" "nat-1a" {
  vpc = true

  tags = {
    Name = "ei-nat-1a"
  }
}

resource "aws_eip" "nat-1b" {
  vpc = true

  tags = {
    Name = "ei-nat-1b"
  }
}

resource "aws_eip" "nat-1c" {
  vpc = true

  tags = {
    Name = "ei-nat-1c"
  }
}

resource "aws_nat_gateway" "az-1a" {
  allocation_id = aws_eip.nat-1a.id
  subnet_id     = aws_subnet.public-1a.id

  tags = {
    Name = "nat-az-1a"
  }

  depends_on = [aws_internet_gateway.taxapp]
}

resource "aws_nat_gateway" "az-1b" {
  allocation_id = aws_eip.nat-1b.id
  subnet_id     = aws_subnet.public-1b.id

  tags = {
    Name = "nat-az-1b"
  }

  depends_on = [aws_internet_gateway.taxapp]
}

resource "aws_nat_gateway" "az-1c" {
  allocation_id = aws_eip.nat-1c.id
  subnet_id     = aws_subnet.public-1c.id

  tags = {
    Name = "nat-az-1c"
  }

  depends_on = [aws_internet_gateway.taxapp]
}