

resource "aws_instance" "web" {
  ami                                  = "ami-0332d564d76dbd8d6"
  associate_public_ip_address          = true
  availability_zone                    = "us-east-1c"
  instance_type                        = "t3.micro"
  key_name                             = "ec2key"
  security_groups                      = ["launch-wizard-2"]
  subnet_id                            = "subnet-05f2e4e8d053fc11c"
  tags = {
    Name = "dev-app-server"
  }
  tags_all = {
    Name = "dev-app-server"
  }
 
}
