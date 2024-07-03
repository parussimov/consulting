provider "aws" {
  region = var.region

  # At the very least, you should have admin and viewer IAM roles. 
  # You can run terraform plan locally with the viewer role and apply changes by merging a PR.
  # assume_role {
  #   role_arn     = "arn:aws:iam::123456789012:role/ROLE_NAME"
  #   session_name = "SESSION_NAME"
  #   external_id  = "EXTERNAL_ID"
  # }
}

terraform {

  backend "local" {
    # Bare minimum is to have a tfstate file for each environment.
    # Pros: Easier to manage.
    # Cons: If you have a lot of components, it’s very slow to refresh the plan, 
    # and you can mess up something and corrupt the entire state for the environment.
    path = "global.tfstate"

    # A better approach is to have a state file for each component, following the same 
    # structure as Terragrunt. The idea is to follow the file path and use it as the state file.
    # path = "global/s3.tfstate"

    # Same bucket/DynamoDB table per environment or different? It's safer in the long run to use 
    # different buckets for each environment, but it also increases the number of components you need to manage. 
    # You can use the same bucket/table and create granular permissions for different groups of users. 
    # For example, an admin user would have full access to the S3 bucket,  s3:/*
    # and QA would only be able to access the 's3:/qa/*' path.
  }

  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.56"
    }
  }
}
