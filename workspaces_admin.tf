
module "admin_workspace" {
  source = "./terraform-aws-modules/workspaces/"

  directory_id          = aws_directory_service_directory.connector.id
  bundle_id             = var.bundle_id # Windows 10 
  user_name             = var.admin_workspace_username

  #workspace_properties

  compute_type_name    = var.compute_type_name
  user_volume_size_gib = var.user_volume
  root_volume_size_gib = var.root_volume
  running_mode         = var.running_mode
}