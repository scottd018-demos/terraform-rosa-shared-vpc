variable "cluster_creator_account_id" {
  type        = string
  description = "The AWS Account ID of the Cluster Creator."
}

variable "rosa_cluster_name" {
  type        = string
  description = "The ROSA cluster that this VPC and associated resources is for."
}

variable "ocm_token" {
  type        = string
  sensitive   = true
  description = "The token to use to authenticate against the OCM API."
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

variable "private" {
  type        = bool
  default     = false
  description = "VPC is for a PrivateLink cluster."
}

variable "multi_az" {
  type        = bool
  default     = false
  description = "VPC is should span multiple availability zones."
}

variable "vpc_cidr" {
  type        = string
  default     = "10.10.0.0/16"
  description = "VPC CIDR."
}

variable "subnet_cidr_size" {
  type        = number
  default     = 20
  description = "Subnet CIDR size.  Subnet CIDR ranges are auto-calculated based on vpc_cidr input."
}
