
module "networking" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.10.0"

  name = var.vpc_name   # vpc name
  cidr = var.cidr_block # vpc cidr block address

  azs              = ["ap-southeast-2a", "ap-southeast-2b"] # availability zone
  private_subnets  = var.private_cidr                       # application private subnet
  public_subnets   = var.public_cidr                        # public subnet 
  database_subnets = var.db_cidr                            # database private subnet

  enable_nat_gateway = true
  single_nat_gateway = true
}

resource "aws_vpn_gateway" "vpn_gw" {
  vpc_id = module.networking.vpc_id

  tags = {
    Name = var.vpn_gw_name
  }
}

resource "aws_customer_gateway" "customer_gw" {
  bgp_asn    = 65000
  ip_address = var.ip_address
  type       = "ipsec.1"

  tags = {
    Name = var.customer_gw_name
  }
}

resource "aws_vpn_connection" "main" {
  customer_gateway_id = aws_customer_gateway.customer_gw.id
  vpn_gateway_id      = module.networking.vgw_id
  type                = "ipsec.1"
  static_routes_only  = true

  tags = {
    "Name" = var.site_to_site_name
  }
}
#Outputs

output "vpc_id" {
  description = "vpc id"
  value       = module.networking.vpc_id
}

output "vpn_gw_Id" {
  description = "vpn gateway Id"
  value       = module.networking.vgw_id
}

output "customer_gw_Id" {
  description = "customer gateway Id"
  value       = aws_customer_gateway.customer_gw.id
}

output "natgw_id" {
  description = "nat gateway Id"
  value       = module.networking.natgw_ids
}

