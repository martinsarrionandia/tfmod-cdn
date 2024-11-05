output "secret-arn" {
  value = resource.aws_secretsmanager_secret_version.this-current.arn
}

output "cdn-bucket-name" {
  value = local.fqdn
}

output "cdn-bucket-region" {
  value = resource.aws_s3_bucket.this.region
}