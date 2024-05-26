provider "aws" {
  region = var.region
}

# module "vpc" {
#   source = "../../../modules/vpc"

#   environment = "dev"
#   cidr_block  = "10.0.0.0/16"
# }

module "vpc" {
  source = "../../../modules/vpc-v2"

  environment          = "dev"
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
}
