data "aws_cloudfront_cache_policy" "this" {
  name = "Managed-CachingOptimized"
}

resource "aws_cloudfront_origin_access_control" "this" {
  name                              = local.fqdn
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_response_headers_policy" "this" {
  name = replace("Cache-Control-${local.fqdn}", ".", "_")

  custom_headers_config {

    items {
      header   = "Cache-Control"
      override = true
      value    = "max-age=31536000"
    }
  }
}

resource "aws_cloudfront_distribution" "this" {
  origin {
    domain_name              = resource.aws_s3_bucket.this.bucket_regional_domain_name
    origin_id                = resource.aws_s3_bucket.this.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.this.id
  }

  http_version = var.http-version
  aliases      = [local.fqdn]
  enabled      = true

  default_cache_behavior {
    cache_policy_id            = data.aws_cloudfront_cache_policy.this.id
    allowed_methods            = ["GET", "HEAD"]
    cached_methods             = ["GET", "HEAD"]
    target_origin_id           = resource.aws_s3_bucket.this.bucket_regional_domain_name
    response_headers_policy_id = aws_cloudfront_response_headers_policy.this.id
    viewer_protocol_policy     = "allow-all"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    minimum_protocol_version = var.min-tls-version
    acm_certificate_arn      = aws_acm_certificate.this.id
    ssl_support_method       = "sni-only"
  }
}