resource "aws_s3_bucket" "taxapp-s3" {
  bucket = "taxapp-s3-audit"

  tags = {
    Name = "taxapp-s3b"
  }
}

data "aws_region" "current" {}

resource "aws_vpc_endpoint" "vpc-s3" {
  vpc_id          = aws_vpc.taxapp.id
  service_name    = "com.amazonaws.${data.aws_region.current.name}.s3"
  route_table_ids = [aws_route_table.private-1a.id, aws_route_table.private-1b.id, aws_route_table.private-1c.id]
}