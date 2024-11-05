output "secret_arn" {
  value = resource.aws_secretsmanager_secret_version.this-current.arn
}

output "cdn_bucket_name" {
  value = local.fqdn
}