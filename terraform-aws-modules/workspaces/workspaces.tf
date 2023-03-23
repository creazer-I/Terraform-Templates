resource "aws_workspaces_workspace" "workspaces" {
  directory_id = var.directory_id
  bundle_id    = var.bundle_id
  user_name    = var.user_name

  root_volume_encryption_enabled = true
  user_volume_encryption_enabled = true
  volume_encryption_key          = var.volume_encryption_key

  workspace_properties {
    compute_type_name                         = var.compute_type_name
    user_volume_size_gib                      = var.user_volume_size_gib
    root_volume_size_gib                      = var.root_volume_size_gib
    running_mode                              = var.running_mode
  }
}