resource "aws_directory_service_directory" "connector" {
  name     = var.ad_name
  password = var.service_password
  size     = "Small"
  type     = "ADConnector"

  connect_settings {
    customer_dns_ips  = var.ad_dns_ip
    customer_username = var.service_username
    subnet_ids        = module.networking.private_subnets
    vpc_id            = module.networking.vpc_id
  }
}