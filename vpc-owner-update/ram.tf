resource "aws_ram_resource_share" "shared_vpc" {
  name                      = "${var.rosa_cluster_name}-shared-vpc"
  allow_external_principals = true
}

data "aws_subnet" "shared_vpc" {
  count = length(var.subnet_ids)
  id    = var.subnet_ids[count.index]
}

resource "aws_ram_resource_association" "shared_vpc" {
  count = length(var.subnet_ids)

  resource_arn       = data.aws_subnet.shared_vpc[count.index].arn
  resource_share_arn = aws_ram_resource_share.shared_vpc.arn
}

resource "aws_ram_principal_association" "shared_vpc" {
  principal          = var.cluster_creator_account_id
  resource_share_arn = aws_ram_resource_share.shared_vpc.arn
}
