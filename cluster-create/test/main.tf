variable "rosa_cluster_name" {}
variable "aws_profile" {}
variable "aws_region" {}
variable "vpc_cidr" {}
variable "dns_domain" {}
variable "oidc_config_id" {}
variable "shared_vpc_role_arn" {}
variable "shared_vpc_zone_id" {}
variable "private" {
  type = bool
}

variable "ocp_version" {
  default = "4.13.13"
}

variable "ocm_token" {
  sensitive = true
}

variable "subnet_ids" {
  type = list(string)
}

variable "availability_zones" {
  type = list(string)
}

module "rosa_private" {
  source = "../"

  private             = true
  multi_az            = false
  autoscaling         = false
  rosa_cluster_name   = var.rosa_cluster_name
  ocp_version         = var.ocp_version
  ocm_token           = var.ocm_token
  subnet_ids          = var.subnet_ids
  availability_zones  = var.availability_zones
  aws_profile         = var.aws_profile
  aws_region          = var.aws_region
  dns_domain          = var.dns_domain
  shared_vpc_role_arn = var.shared_vpc_role_arn
  shared_vpc_zone_id  = var.shared_vpc_zone_id
  oidc_config_id      = var.oidc_config_id
  vpc_cidr            = var.vpc_cidr
}

output "rosa_private" {
  value = module.rosa_private
}
