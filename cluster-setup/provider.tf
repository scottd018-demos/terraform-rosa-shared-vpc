terraform {
  required_providers {
    rhcs = {
      version = "~> 1.3.0"
      source  = "terraform-redhat/rhcs"
    }
  }
}

provider "rhcs" {
  token = var.ocm_token
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}
