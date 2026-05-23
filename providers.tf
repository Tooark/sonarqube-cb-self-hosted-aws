provider "aws" {
  region  = var.account_region

  default_tags {
    tags = var.default_tags
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.4.0"
    }
  }
  
  # backend "s3" {
  #   bucket         = "your-terraform-state-bucket"
  #   key            = "gitlab/terraform.tfstate"
  #   region         = "us-east-1"
  #   encrypt        = true
  #   dynamodb_table = "terraform-lock"
  # }
}