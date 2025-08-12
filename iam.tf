data "aws_iam_policy_document" "this_cloudfront" {
  statement {
    sid    = "AllowCloudFrontServicePrincipalReadOnly"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.this.arn}/*"]
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.this.arn]
    }
  }
}

data "aws_iam_policy_document" "this_s3_document" {
  statement {
    actions = ["s3:ListAccessPointsForObjectLambda",
      "s3:GetAccessPoint",
      "s3:PutAccountPublicAccessBlock",
      "s3:ListAccessPoints",
      "s3:CreateStorageLensGroup",
      "s3:ListJobs",
      "s3:PutStorageLensConfiguration",
      "s3:ListMultiRegionAccessPoints",
      "s3:ListStorageLensGroups",
      "s3:ListStorageLensConfigurations",
      "s3:GetAccountPublicAccessBlock",
      "s3:ListAllMyBuckets",
      "s3:ListAccessGrantsInstances",
      "s3:PutAccessPointPublicAccessBlock",
    "s3:CreateJob"]
    effect    = "Allow"
    resources = ["*"]
    sid       = "AllowIAMUserReadS3Operations"
  }
  statement {
    actions = ["s3:*"]
    effect  = "Allow"
    resources = ["${aws_s3_bucket.this.arn}",
    "${aws_s3_bucket.this.arn}/*"]
    sid = "AllowIAMUserReadWriteBucketAccess"
  }
}

resource "aws_iam_policy" "this_s3_policy" {
  name   = "s3-${local.fqdn}-policy"
  policy = data.aws_iam_policy_document.this_s3_document.json
}

resource "aws_iam_user" "this" {
  name = "s3-${local.fqdn}"
  tags = {
    tag-key = "s3"
  }
}

resource "aws_iam_user_policy_attachment" "this_s3_policy_attach" {
  user       = aws_iam_user.this.name
  policy_arn = aws_iam_policy.this_s3_policy.arn
}

resource "aws_iam_access_key" "this" {
  user = aws_iam_user.this.name
}