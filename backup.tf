
# Backup Plan
resource "aws_backup_plan" "backup_plan" {
  name = "tf_example_backup_plan"

  rule {
    rule_name         = var.Backup_Rule_Name
    target_vault_name = aws_backup_vault.vault.name
    schedule          = "cron(0 13 * * ? *)"
  }

  advanced_backup_setting {
    backup_options = {
      WindowsVSS = "enabled"
    }
    resource_type = "EC2"
  }
}

# Backup by Resources
resource "aws_backup_selection" "resources_selection" {
  iam_role_arn = aws_iam_role.example.arn
  name         = "tf_example_backup_selection"
  plan_id      = aws_backup_plan.example.id

  resources = [
    aws_db_instance.example.arn,
    aws_ebs_volume.example.arn,
    aws_efs_file_system.example.arn,
  ]
}

# Backup Vault
resource "aws_backup_vault" "vault" {
  name        = "example_backup_vault"
  kms_key_arn = aws_kms_key.example.arn
}