locals {
  flow_logs_bucket_name = "${var.flow_logs_bucket_name}-${var.env}-${var.region}"
}

module "logs_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.2.0"

  bucket        = local.flow_logs_bucket_name
  acl           = "private"
  policy        = data.aws_iam_policy_document.flow_log_s3.json
  attach_policy = true
  force_destroy = true

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }

  # S3 bucket-level Public Access Block configuration
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}

module "fastapi_static_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.2.0"

  bucket        = "${var.env}-${var.app_name}-static-${var.region}"
  force_destroy = true

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }

  # S3 bucket-level Public Access Block configuration
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
  cors_rule = [
    {
      allowed_methods = ["PUT", "POST", "GET"]
      allowed_origins = ["*"]
      allowed_headers = ["*"]
      expose_headers  = []
    }
  ]

}

# IAM policy for S3

data "aws_iam_policy_document" "flow_log_s3" {
  statement {
    sid = "AWSLogDeliveryWrite"

    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }

    actions = ["s3:PutObject"]

    resources = ["arn:aws:s3:::${local.flow_logs_bucket_name}/AWSLogs/*"]
  }

  statement {
    sid = "AWSLogDeliveryAclCheck"

    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }

    actions = ["s3:GetBucketAcl"]

    resources = ["arn:aws:s3:::${local.flow_logs_bucket_name}"]
  }
}
