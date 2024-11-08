resource "aws_s3_bucket" "this" {
  bucket = local.fqdn
  lifecycle {
   prevent_destroy = true
 }
}

resource "aws_s3_bucket_policy" "this" {
  bucket = resource.aws_s3_bucket.this.id
  policy = data.aws_iam_policy_document.this_cloudfront.json
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = resource.aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}