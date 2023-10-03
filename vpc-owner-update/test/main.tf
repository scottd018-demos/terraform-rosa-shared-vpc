variable "rosa_cluster_name" {}
variable "aws_profile" {}
variable "aws_region" {}
variable "shared_vpc_role_name" {}
variable "subnet_ids" {
  type = list(string)
}

import {
  to = module.vpc_owner_update.aws_iam_role.shared_vpc
  id = "dscott-test-shared-vpc"
}

module "vpc_owner_update" {
  source = "../"

  cluster_creator_account_id = "660250927410"
  rosa_cluster_name          = var.rosa_cluster_name
  aws_profile                = var.aws_profile
  aws_region                 = var.aws_region
  shared_vpc_role_name       = var.shared_vpc_role_name
  subnet_ids                 = var.subnet_ids
}

output "vpc_owner_update" {
  value = module.vpc_owner_update
}
