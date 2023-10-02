locals {
  iam_name = "${var.rosa_cluster_name}-shared-vpc"
}

#
# aws config
#
data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

#
# shared vpc policy documents
#
data "aws_iam_policy_document" "shared_vpc" {
  statement {
    sid       = "SharedVPCUpdatesROSA"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "route53:ChangeResourceRecordSets",
      "route53:ListHostedZones",
      "route53:ListHostedZonesByName",
      "route53:ListResourceRecordSets",
      "route53:ChangeTagsForResource",
      "route53:GetAccountLimit",
      "route53:GetChange",
      "route53:GetHostedZone",
      "route53:ListTagsForResource",
      "route53:UpdateHostedZoneComment",
      "tag:GetResources",
      "tag:UntagResources"
    ]
  }
}

data "aws_iam_policy_document" "shared_vpc_trust" {
  statement {
    sid     = "SharedVPCTrustROSA"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "AWS"
      identifiers = [
        "arn:${data.aws_partition.current.partition}:iam::${var.cluster_creator_account_id}:root"
      ]
    }
  }
}

#
# policies/roles
#
resource "aws_iam_policy" "shared_vpc" {
  name   = local.iam_name
  policy = data.aws_iam_policy_document.shared_vpc.json
}

resource "aws_iam_role" "shared_vpc" {
  name               = local.iam_name
  assume_role_policy = data.aws_iam_policy_document.shared_vpc_trust.json
}

resource "aws_iam_role_policy_attachment" "shared_vpc" {
  role       = aws_iam_role.shared_vpc.name
  policy_arn = aws_iam_policy.shared_vpc.arn
}

output "shared_vpc_role" {
  value = aws_iam_role.shared_vpc.arn
}
