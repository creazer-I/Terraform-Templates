resource "aws_cloudwatch_log_metric_filter" "this" {
  count = var.isEnabled ? 1 : 0
  log_group_name = var.log_group_name
  name = var.name
  pattern = var.pattern

  dynamic "metric_transformation" {
    for_each = var.metric_transformation ==null ? []: var.metric_transformation
    content {
      default_value = try(metric_transformation.value["default_value"], null)
      name = metric_transformation.value["name"]
      namespace = metric_transformation.value["namespace"]
      value = metric_transformation.value["value"]
      unit = try(metric_transformation.value["unit"], "None")
      dimensions = try(metric_transformation.value["dimensions"], null)
    }
  }
}