locals {
  region_vars = read_terragrunt_config("${get_repo_root()}/core/global/region.hcl")
  aws_region  = local.region_vars.locals.aws_region
  cust_region = local.region_vars.locals.cust_region

  org_name              = "datapay"
  organization_id       = ""
  logging_account_id    = ""
  audit_account_id      = ""
  management_account_id = ""

  state_bucket   = "${local.org_name}-core-config"
  dynamodb_table = "${local.org_name}-core-config"
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket                 = "${local.state_bucket}"
    key                    = "${path_relative_to_include()}/terraform.tfstate"
    region                 = "${local.aws_region}"
    encrypt                = true
    skip_bucket_versioning = false
    dynamodb_table         = "${local.dynamodb_table}"
  }
}

inputs = {}
