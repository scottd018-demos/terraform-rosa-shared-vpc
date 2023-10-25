resource "aws_route53_zone" "private" {
  name = var.route53_zone

  vpc {
    vpc_id = data.aws_subnet.shared_vpc[0].vpc_id
  }
}

output "zone_id" {
  value = aws_route53_zone.private.zone_id
}
