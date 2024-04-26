variable "retention_in_days" {
  description = "Number of days you want to retain log events in the log group"
  type = number
  default     = "30"
}

variable "cloudwatch_loggroup_name" {
  description = "The name of the log group. If omitted, Terraform will assign a random, unique name."
  type = string
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource"
 
}


variable "create_cloudwatch_loggroup" {
  type        = bool
  description = "A boolean that indicates whether to create Cloud Watch log group or not. Default is true"
  default     = true
}

variable "aws_kms_key_arn" {
  description = "(Required) The ARN of the KMS Key to use when encrypting log data. Please note, after the AWS KMS CMK is disassociated from the log group, AWS CloudWatch Logs stops encrypting newly ingested data for the log group. All previously ingested data remains encrypted, and AWS CloudWatch Logs requires permissions for the CMK whenever the encrypted data is requested."
  type        = string
}