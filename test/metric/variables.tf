variable "log_group_name" {
  description = "The name of the log group to associate the metric filter with."
  type        = string
}

variable "name" {
  description = " A name for the metric filter."
  type        = string
}

variable "pattern" {
  description = "A valid CloudWatch Logs filter pattern for extracting metric data out of ingested log events."
  type        = string
}

variable "metric_transformation" {
  description = "metric transformation"
  type = set(any)
}
variable "isEnabled" {
  default     = true
  type        = bool
  description = "isEnabled"
}