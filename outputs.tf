output "secret_arn" {
  value = resource.aws_secretsmanager_secret_version.this-current.arn
}