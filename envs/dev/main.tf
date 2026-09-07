#VPC
module "vpc" {
  source         = "../../modules/vpc"
  vpc_cidr_block = "192.168.0.0/16"
  vpc_name       = "dev-vpc"
}

#Frontend
module "frontend" {
  source                = "../../modules/frontendaws"
  bucket_name           = "frontend.brennclnx.best"
  aws_origin_acess_name = "cross access from cloudfront"
  cert_domain           = "*.brennclnx.best"
  dns_record            = "frontend.brennclnx.best"
  hosted_zone_name      = "brennclnx.best"
}