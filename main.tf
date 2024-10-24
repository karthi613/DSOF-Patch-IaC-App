provider "aws" {
  region                      = var.region
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0.0"
    }
  }

  required_version = ">= 1.3.0"  # Adjust based on your Terraform version needs
}

resource "aws_iam_account_password_policy" "strict" {
  minimum_password_length = 14
  require_lowercase_characters   = true
  require_numbers                = true
  require_uppercase_characters   = true
  require_symbols                = true
  allow_users_to_change_password = true
  password_reuse_prevention      = 24 
  max_password_age = 3
}

module "vpc" {
  source = "./modules/vpc"
}

module "storage" {
  source = "./modules/storage"
}

module "cloudtrail" {
  source = "./modules/cloudtrail"
  kms_key_id = module.pki.kms_key
  depends_on = [ module.pki ]
}

module "pki" {
  source = "./modules/pki"
}