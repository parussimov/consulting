provider "aws" {
  region = var.region
}

# Example of accessing remote state
data "terraform_remote_state" "vpc" {
  backend = "local"
  config = {
    path = "../vpc/terraform.tfstate"
  }
}

module "subnet" {
  source = "../../../modules/subnet"

  environment = "dev"
  vpc_id      = data.terraform_remote_state.vpc.outputs.id
  cidr_block  = "10.0.0.0/19"
}
