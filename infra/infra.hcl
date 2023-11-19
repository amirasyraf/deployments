locals {
  region_vars  = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))

  aws_region = local.region_vars.locals.aws_region
  account_id = local.account_vars.locals.account_id
  account_type = local.account_vars.locals.account_type
  account_name = local.account_vars.locals.account_name
  
  org_name = "amirdatacom"
  product_name = "datapay"
  assume_role_name = "AWSControlTowerExecution"

  default_tags = {
    org_name = local.org_name
    product_name = local.product_name
  }

  additional_tags = local.account_vars.locals
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket                 = "${local.org_name}-${local.product_name}-${local.aws_region}-tfstate"
    key                    = "${path_relative_to_include()}/terraform.tfstate"
    region                 = "${local.aws_region}"
    encrypt                = true
    skip_bucket_versioning = false
    dynamodb_table         = "${local.org_name}-${local.product_name}-${local.aws_region}-tflock"
    role_arn               = "arn:aws:iam::${local.account_id}:role/${local.assume_role_name}"
  }
}

inputs = {
  aws_region = local.aws_region
  account_id = local.account_id
  account_type = local.account_type
  account_name = local.account_name
  org_name = local.org_name
  product_name = local.product_name
  assume_role_name = local.assume_role_name
  tags = merge(local.default_tags, local.additional_tags)
}
