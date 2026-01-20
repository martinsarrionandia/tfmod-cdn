output "secret_arn" {
  value = resource.aws_secretsmanager_secret_version.this_current.arn
}

output "cdn_bucket_name" {
  value = local.fqdn
}

output "cdn_bucket_region" {
  value = aws_s3_bucket.this.region
}

output "cdn_bucket_arn" {
  value = aws_s3_bucket.this.arn
}