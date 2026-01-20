resource "aws_secretsmanager_secret" "this" {
  description = "User s3-cdn.${var.domain} access key details"

}

resource "aws_secretsmanager_secret_version" "this_current" {
  secret_id     = resource.aws_secretsmanager_secret.this.id
  secret_string = "{\"aws_access_key_id\":\"${aws_iam_access_key.this.id}\",\"aws_secret_access_key\":\"${aws_iam_access_key.this.secret}\"}"
}

resource "aws_kms_key" "this" {
  description             = "s3-${var.domain}"
  deletion_window_in_days = 7
  tags = {
    Name = "s3-${var.domain}"
  }
}

resource "aws_kms_alias" "this" {
  name          = replace("alias/secret-${var.domain}-key", ".", "_")
  target_key_id = aws_kms_key.this.key_id
}