resource "aws_cloudtrail" "cloudtrail" {
  depends_on = [
    aws_s3_bucket.cloudtrail_bucket
  ]
  name                          = var.cloudtrail_name
  s3_bucket_name                = aws_s3_bucket.cloudtrail_bucket.id
  include_global_service_events = true
  enable_logging                = true
  enable_log_file_validation    = true
  is_multi_region_trail         = true
  event_selector {
    read_write_type           = "All"
    include_management_events = true

    data_resource {
      type   = "AWS::S3::Object"
      values = ["arn:${data.aws_partition.current.partition}:s3:::"]
    }
  }

}

# S3 Bucket for Storing Logs of Cloudtrail with server-side-encryption

resource "aws_s3_bucket" "cloudtrail_bucket" {
  bucket = var.s3_bucket_name
  force_destroy = true
  acl    = var.bucket_acl
  versioning {
    enabled = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  #Delete old version -Life Cycle

  lifecycle_rule {
    id                                     = "amcp-oldversion-del"
    enabled                                = true
    abort_incomplete_multipart_upload_days = var.abort_incomplete_multipart_upload
    noncurrent_version_expiration {
      days = var.noncurrent_version_exp_days
    }
  }

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AWSCloudTrailAclCheck",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:GetBucketAcl",
            "Resource": "arn:aws:s3:::${var.s3_bucket_name}"
        },
        {
            "Sid": "AWSCloudTrailWrite",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::${var.s3_bucket_name}/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": "bucket-owner-full-control"
                }
            }
        }
    ]
}
POLICY
}

resource "aws_s3_bucket_public_access_block" "public_access_config" {
  bucket = aws_s3_bucket.cloudtrail_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}