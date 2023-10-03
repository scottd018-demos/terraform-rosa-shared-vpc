locals {
  iam_name = "${var.rosa_cluster_name}-shared-vpc"
}

#
# aws config
#
data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

#
# policies/roles
#
resource "aws_iam_role" "shared_vpc" {
  name               = var.shared_vpc_role_name
  assume_role_policy = data.aws_iam_policy_document.shared_vpc_trust.json
}

data "aws_iam_policy_document" "shared_vpc_trust" {
  statement {
    sid     = "SharedVPCTrustROSA"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "AWS"
      identifiers = [
        "arn:${data.aws_partition.current.partition}:iam::${var.cluster_creator_account_id}:role/${var.rosa_cluster_name}-openshift-ingress-operator-cloud-credentials",
        "arn:${data.aws_partition.current.partition}:iam::${var.cluster_creator_account_id}:role/${var.rosa_cluster_name}-Installer-Role"
      ]
    }
  }
}
