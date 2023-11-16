locals {
  region_vars  = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  cust_vars    = read_terragrunt_config(find_in_parent_folders("customer.hcl"))
  env_vars     = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))

  aws_region = local.region_vars.locals.aws_region
  cust_name  = local.cust_vars.locals.cust_name
  env        = local.env_vars.locals.env
  account_id = local.account_vars.locals.account_id

  org_name     = ""

  tf_state_bucket = "${local.org_name}-${local.cust_name}-${local.aws_region}-${local.env}-tfstate"
  tf_lock_table   = "${local.org_name}-${local.cust_name}-${local.aws_region}-${local.env}-tflock"

  assume_role_name = ""
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {

    bucket                 = "${local.tf_state_bucket}"
    key                    = "${path_relative_to_include()}/terraform.tfstate"
    region                 = "${local.aws_region}"
    encrypt                = true
    skip_bucket_versioning = false
    dynamodb_table         = "${local.tf_lock_table}"
    role_arn               = "arn:aws:iam::${local.account_id}:role/AWSControlTowerExecution"
  }
}

inputs = {
  assume_role_name = local.assume_role_name
  org_name         = local.org_name
}
