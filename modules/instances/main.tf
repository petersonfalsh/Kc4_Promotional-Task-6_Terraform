
resource "aws_instance" "public_instance" {
  ami             = "ami-0c38b837cd80f13bb" 
  instance_type   = "t2.micro"
  subnet_id       = var.public_subnet_id
  security_groups = [var.public_sg_id]
  key_name        = var.key_name

  user_data = var.nginx_script

  tags = {
    Name = "PublicInstance"
  }
}

resource "aws_instance" "private_instance" {
  ami             = "ami-0c38b837cd80f13bb" 
  instance_type   = "t2.micro"
  subnet_id       = var.private_subnet_id
  security_groups = [var.private_sg_id]
  key_name        = var.key_name

  user_data = var.postgresql_script

  tags = {
    Name = "PrivateInstance"
  }
}
