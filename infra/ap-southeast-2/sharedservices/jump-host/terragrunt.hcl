include "root" {
  path = find_in_parent_folders("core.hcl")
}

terraform {
  source = "git@github.com:amirasyraf/terraform-modules.git//module?ref=v0.0.1"
}

dependencies {
  paths = [""]
}

locals {

}

inputs = {
  
}
