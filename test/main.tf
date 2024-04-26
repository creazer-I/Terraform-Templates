data "aws_kms_key" "this" {
  count  = var.create_cloudwatch_loggroup == true ? 1 : 0
  key_id = var.aws_kms_key_arn
}

resource "aws_cloudwatch_log_group" "cloudwatch_lg" {
  count             = var.create_cloudwatch_loggroup == true ? 1 : 0
  name              = var.cloudwatch_loggroup_name
  retention_in_days = var.retention_in_days
  kms_key_id  = data.aws_kms_key.this[0].id == null ? "KMS Key is not valid" : var.aws_kms_key_arn
  tags              = var.tags
}