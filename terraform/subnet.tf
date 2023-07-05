#######PRIVATE
resource "aws_subnet" "api-private-1a" {
  vpc_id            = aws_vpc.taxapp.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    "Name" = "api-subnet-private-1a"
  }
}

resource "aws_subnet" "api-private-1b" {
  vpc_id            = aws_vpc.taxapp.id
  cidr_block        = "10.0.10.0/24"
  availability_zone = "us-east-1b"

  tags = {
    "Name" = "api-subnet-private-1b"
  }
}

resource "aws_subnet" "api-private-1c" {
  vpc_id            = aws_vpc.taxapp.id
  cidr_block        = "10.0.100.0/24"
  availability_zone = "us-east-1c"

  tags = {
    "Name" = "api-subnet-private-1c"
  }
}

############PUBLIC
resource "aws_subnet" "public-1a" {
  vpc_id                  = aws_vpc.taxapp.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    "Name" = "subnet-public-1a"
  }
}

resource "aws_subnet" "public-1b" {
  vpc_id                  = aws_vpc.taxapp.id
  cidr_block              = "10.0.20.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    "Name" = "subnet-public-1b"
  }
}

resource "aws_subnet" "public-1c" {
  vpc_id                  = aws_vpc.taxapp.id
  cidr_block              = "10.0.200.0/24"
  availability_zone       = "us-east-1c"
  map_public_ip_on_launch = true

  tags = {
    "Name" = "subnet-public-1c"
  }
}

#######DB
resource "aws_subnet" "db-private-1a" {
  vpc_id            = aws_vpc.taxapp.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1a"

  tags = {
    "Name" = "db-subnet-private-1a"
  }
}

resource "aws_subnet" "db-private-1b" {
  vpc_id            = aws_vpc.taxapp.id
  cidr_block        = "10.0.30.0/24"
  availability_zone = "us-east-1b"

  tags = {
    "Name" = "db-subnet-private-1b"
  }
}

resource "aws_subnet" "db-private-1c" {
  vpc_id            = aws_vpc.taxapp.id
  cidr_block        = "10.0.40.0/24"
  availability_zone = "us-east-1c"

  tags = {
    "Name" = "db-subnet-private-1c"
  }
}
