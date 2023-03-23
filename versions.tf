terraform {
  required_version = ">= 0.13.0"
  required_providers {
    aws = {
      version = "~> 3.0, >= 3.38.0"
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Environment = "${var.environment}"
      Terraform   = "true"
    }
  }
}