output "shared-vpc-common" {
  description = "Shared VPC network name."
  value = module.shared-vpc-common.subnets_self_links
}