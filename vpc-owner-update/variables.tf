variable "cluster_creator_account_id" {
  type        = string
  description = "The AWS Account ID of the Cluster Creator."
}

variable "rosa_cluster_name" {
  type = string
}

variable "subnet_ids" {
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

variable "shared_vpc_role_name" {
  type        = string
  description = "The Shared VPC Role name created by the VPC owner in the VPC owner account."
}

variable "route53_zone" {
  type        = string
  description = "Domain value from cluster setup"
}
