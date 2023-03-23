variable "environment" {
  type        = string
  description = "environment"
  default     = "prod"
}

variable "region" {
  type        = string
  description = "region"
  default     = "ap-southeast-2"
}

# Cloudtrail

variable "s3_bucket_name" {
  type        = string
  description = "s3 Bucket name for cloudtrail"
  default     = "prod-cloudtrailbucket"
}

variable "bucket_acl" {
  type        = string
  description = "s3 Bucket Acl"
  default     = "private"
}

variable "abort_incomplete_multipart_upload" {
  type        = string
  description = "Specifies the number of days after initiating a multipart upload when the multipart upload must be completed"
  default     = "7"
}

variable "noncurrent_version_exp_days" {
  type        = string
  description = "Specifies when noncurrent object versions expire"
  default     = "7"
}

variable "cloudtrail_name" {
  type        = string
  description = "cloudtrail service name"
  default     = "prod-cloudtrail"
}
