include "root" {
  path = find_in_parent_folders("infra.hcl")
}

include "config" {
  path = "${get_repo_root()}/infra/_common/vpc.hcl"
}

inputs = {
  vpc_cidr = "10.0.0.0/20"
}
