data "aws_route53_zone" "selected" {
  name         = "brennclnx.best."
  private_zone = false
}


#Look up existing route53 hosted zon e for domain
data "aws_route53_zone" "primary" {
    name  = "brennclnx.best"
    private_zone = false
  
}

#look up for existing wildcard ACM cert
data "aws_acm_certificate" "wildcard" {
    domain = "*.brennclnx.best"
    statuses = ["ISSUED"]
    most_recent = true
  
}

 #Generate an IAM policy document granting S3 access to CloudFront OAC

data "aws_iam_policy_document" "s3_oac_policy" {
  statement {

    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.frontend_bucket.arn}/*"]
    principals {

      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]

    }

    condition {

      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.frontend_cdn.arn]

    }

  }

}