variable "private" {
  type    = bool
  default = false
}

variable "multi_az" {
  type    = bool
  default = false
}

variable "autoscaling" {
  type    = bool
  default = true
}

variable "ocm_token" {
  type      = string
  sensitive = true
}

variable "rosa_cluster_name" {
  type = string
}

variable "ocp_version" {
  type    = string
  default = "4.13.13"
}

variable "vpc_cidr" {
  type    = string
  default = "10.10.0.0/16"
}

variable "subnet_ids" {
  type = list(string)
}

variable "availability_zones" {
  type = list(string)
}

variable "aws_profile" {
  type        = string
  description = "The local AWS Configuration profile used to authenticate against AWS."
}

variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "The AWS region to deploy VPC and associated resources into."
}

variable "dns_domain" {
  type = string
}

variable "oidc_config_id" {
  type = string
}

variable "shared_vpc_role_arn" {
  type        = string
  description = "The Shared VPC Role ARN created by the VPC owner in the VPC owner account."
}

variable "shared_vpc_zone_id" {
  type        = string
  description = "The Shared VPC hosted zone id associated with the shared VPC."
}
