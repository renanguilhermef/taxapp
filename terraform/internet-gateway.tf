resource "aws_internet_gateway" "taxapp" {
  vpc_id = aws_vpc.taxapp.id

  tags = {
    Name = "taxapp-internet-gateway"
  }
}
