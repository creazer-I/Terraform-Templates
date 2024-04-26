output "arn" {
  description = "The Amazon Resource Name (ARN) specifying the log group."
  value       = var.create_cloudwatch_loggroup ? element(concat(aws_cloudwatch_log_group.cloudwatch_lg.*.arn, [""]), 0) : null
}

output "name" {
  description = "The name specifying the log group."
  value       = var.create_cloudwatch_loggroup ? element(concat(aws_cloudwatch_log_group.cloudwatch_lg.*.name, [""]), 0) : null
}