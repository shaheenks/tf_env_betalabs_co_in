output "shared-vpc-common-network" {
  description = "Shared VPC network name."
  value = module.shared-vpc-common.network_self_link
}

output "shared-vpc-common-subnets" {
  description = "Shared VPC network name."
  value = module.shared-vpc-common.subnets_self_links
}

output "shared-vpc-common-secondary_ranges" {
  description = "Shared VPC network name."
  value = module.shared-vpc-common.subnets_secondary_ranges
}