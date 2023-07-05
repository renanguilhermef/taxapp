resource "aws_launch_template" "taxapp-api" {
  name                   = "taxapp-api-ec2-template"
  image_id               = "ami-06b09bfacae1453cb"
  key_name               = "terraform"
  vpc_security_group_ids = [aws_security_group.taxapp-api.id]
  user_data              = filebase64("api-user-data.sh")
}

locals {
  subnet_ids = [
    aws_subnet.db-private-1a.id,
    aws_subnet.db-private-1b.id,
    aws_subnet.db-private-1c.id
  ]
  private_ips = ["10.0.3.10", "10.0.30.10", "10.0.40.10"]
}


resource "aws_instance" "taxapp-db" {
  ami                    = "ami-06b09bfacae1453cb"
  instance_type          = "t2.large"
  key_name               = "terraform"
  user_data_base64       = filebase64("db-user-data.sh")
  vpc_security_group_ids = [aws_security_group.taxapp-db.id]
  count                  = 3
  subnet_id              = element(local.subnet_ids, count.index)
  private_ip             = element(local.private_ips, count.index)


  tags = {
    Name = "taxapp-mysqldb0${count.index + 1}"
  }

  depends_on = [aws_nat_gateway.az-1a, aws_nat_gateway.az-1b, aws_nat_gateway.az-1c]

}