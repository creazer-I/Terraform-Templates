resource "aws_fsx_windows_file_system" "fsx" {

  storage_capacity    = 100
  subnet_ids          = module.networking.database_subnets
  throughput_capacity = 1024

  self_managed_active_directory {
    dns_ips     = var.fsx_dns_ips # IPv4 addresses of the DNS servers for your domain
    domain_name = var.fqdn_ad
    password    = var.service_password
    username    = var.service_username
  }
  depends_on = [
    aws_directory_service_directory.connector
  ]
}
