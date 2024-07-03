# Example of accessing remote state
data "terraform_remote_state" "vpc" {
  backend = "local"
  config = {
    path = "../vpc/terraform.tfstate"
  }
}

resource "aws_subnet" "private" {
  # vpc_id   = dependency.vpc.outputs.vpc_id
  vpc_id     = data.terraform_remote_state.vpc.outputs.vpc_id
  cidr_block = var.cidr_block

  tags = {
    "Name" = "${var.environment}-private"
  }
}

# dependency.vpc.outputs.vpc_id

# In Terragrunt we would use dependency instead
# dependency "vpc" {
#   config_path = "../vpc"

#   mock_outputs = {
#     vpc_id = "vpc-123424"
#   }
# }
