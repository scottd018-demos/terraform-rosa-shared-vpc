variable "aws_profile" {}
variable "aws_region" {}
variable "rosa_cluster_name" {}
variable "shared_vpc_role_arn" {}
variable "ocm_token" {
  sensitive = true
}

module "cluster_init" {
  source = "../"

  ocm_token           = var.ocm_token
  aws_profile         = var.aws_profile
  aws_region          = var.aws_region
  rosa_cluster_name   = var.rosa_cluster_name
  shared_vpc_role_arn = var.shared_vpc_role_arn
}

output "cluster_init" {
  value = module.cluster_init
}
