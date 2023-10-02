variable "ocm_token" {
  type        = string
  sensitive   = true
  description = "The token to use to authenticate against the OCM API."
}

variable "rosa_cluster_name" {
  type        = string
  description = "The ROSA cluster that this VPC and associated resources is for."
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

variable "openshift_major_version" {
  type        = string
  default     = "4.13"
  description = "Major release version for the OpenShift cluster."
}

variable "shared_vpc_role_arn" {
  type        = string
  description = "The Shared VPC Role ARN created by the VPC owner in the VPC owner account."
}
