data "aws_workspaces_bundle" "custom_windows_10" {
  bundle_id = var.custom_bundle # Value with Windows 10 (English)
}

module "fleet_workspaces" {
  count  = var.workspaces_count
  source = "./terraform-aws-modules/workspaces/"


  directory_id          = aws_directory_service_directory.connector.id
  bundle_id             = data.aws_workspaces_bundle.custom_windows_10.id # Windows 10 
  user_name             = var.workspaces_username
  
  #workspace_properties

  compute_type_name    = var.compute_type_name
  user_volume_size_gib = var.user_volume
  root_volume_size_gib = var.root_volume
  running_mode         = var.running_mode
}