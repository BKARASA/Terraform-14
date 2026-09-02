module "vpc" {
  source         = "../../modules/vpc"
  vpc_cidr_block = "172.168.0.0/16"
  vpc_name       = "prod-vpc"
}