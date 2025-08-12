output "secret-arn" {
  value = resource.aws_secretsmanager_secret_version.this-current.arn
}

output "cdn-bucket-name" {
  value = local.fqdn
}

output "cdn-bucket-region" {
  value = aws_s3_bucket.this.region
}

output "s3-policy-arn" {
  value = aws_iam_policy.this_s3_policy.arn
}