resource "rhcs_dns_domain" "shared_vpc" {}

resource "rhcs_rosa_oidc_config" "shared_vpc" {
  managed = true
}

resource "rhcs_rosa_oidc_config_input" "shared_vpc" {
  region = var.aws_region
}

output "dns_domain_id" {
  value = rhcs_dns_domain.shared_vpc.id
}

output "oidc_config_id" {
  value = rhcs_rosa_oidc_config.shared_vpc.id
}
