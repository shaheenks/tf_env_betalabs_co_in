output "shared-vpc-common" {
  description = "Shared VPC network name."
  value = module.shared-vpc-common.subnets_self_links
}

output "shared-vpc-common-secondary_ranges" {
  description = "Shared VPC network name."
  value = module.shared-vpc-common.subnets_secondary_ranges
}