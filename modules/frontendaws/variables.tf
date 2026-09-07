variable "bucket_name" {
    description = "bucket_name"
  
}
variable "aws_origin_acess_name" {
  
}
variable "cloudfront_default_object" {
    default=  "index.html"
  
}
variable "cloudfront_origin_id" {
    default = "S3-terraform.brennclnx.best"
  
}
variable "cert_domain" {
    
}

variable "dns_record" {
  
}

variable "hosted_zone_name" {

}