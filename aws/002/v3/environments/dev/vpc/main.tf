provider "aws" {
  region = var.region
}

module "vpc" {
  source = "git@github.com:antonputra/terraform-aws-vpc.git?ref=0.1.0"

  environment = "dev"
  cidr_block  = "10.0.0.0/16"
}

