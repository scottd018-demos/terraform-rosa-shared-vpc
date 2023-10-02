variable "rosa_cluster_name" {}
variable "aws_profile" {}
variable "aws_region" {}
variable "vpc_cidr" {}
variable "private" {
  type = bool
}
variable "subnet_cidr_size" {
  type = number
}
variable "ocm_token" {
  sensitive = true
}

module "vpc_owner_setup" {
  source = "../"

  cluster_creator_account_id = "660250927410"
  rosa_cluster_name          = var.rosa_cluster_name
  aws_profile                = var.aws_profile
  aws_region                 = var.aws_region
  ocm_token                  = var.ocm_token
  vpc_cidr                   = var.vpc_cidr
  subnet_cidr_size           = var.subnet_cidr_size
  private                    = var.private
}

output "vpc_owner_setup" {
  value = module.vpc_owner_setup
}
