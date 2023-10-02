data "rhcs_policies" "all_policies" {}

data "rhcs_versions" "all" {}

data "rhcs_rosa_operator_roles" "operator_roles" {
  operator_role_prefix = var.rosa_cluster_name
  account_role_prefix  = var.rosa_cluster_name
}

module "roles" {
  source  = "terraform-redhat/rosa-sts/aws"
  version = "0.0.14"

  create_operator_roles        = true
  create_account_roles         = true
  create_oidc_provider         = true
  create_oidc_config_resources = false

  cluster_id                  = ""
  rh_oidc_provider_thumbprint = rhcs_rosa_oidc_config.shared_vpc.thumbprint
  rh_oidc_provider_url        = rhcs_rosa_oidc_config.shared_vpc.oidc_endpoint_url
  account_role_prefix         = var.rosa_cluster_name
  ocm_environment             = "production"
  rosa_openshift_version      = var.openshift_major_version
  account_role_policies       = data.rhcs_policies.all_policies.account_role_policies
  operator_role_policies      = data.rhcs_policies.all_policies.operator_role_policies
  operator_roles_properties   = data.rhcs_rosa_operator_roles.operator_roles.operator_iam_roles
  all_versions                = data.rhcs_versions.all

  # shared vpc and oidc inputs
  shared_vpc_role_arn     = var.shared_vpc_role_arn
  bucket_name             = rhcs_rosa_oidc_config_input.shared_vpc.bucket_name
  jwks                    = rhcs_rosa_oidc_config_input.shared_vpc.jwks
  discovery_doc           = rhcs_rosa_oidc_config_input.shared_vpc.discovery_doc
  private_key             = rhcs_rosa_oidc_config_input.shared_vpc.private_key
  private_key_file_name   = rhcs_rosa_oidc_config_input.shared_vpc.private_key_file_name
  private_key_secret_name = rhcs_rosa_oidc_config_input.shared_vpc.private_key_secret_name

  tags = {
    owner = "dscott"
  }
}

output "roles" {
  value = module.roles
}
