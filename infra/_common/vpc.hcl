terraform {
  source = "git@github.com:amirasyraf/terraform-modules.git//vpc?ref=master"
}

locals {}

inputs = {
  create_vpc = true
  enable_dns_hostnames = true
  enable_dns_support = true
  subnet_availability_zones = ["a", "b", "c"]
}