# VPC and Subnets
module "shared-vpc-common" {
  source  = "terraform-google-modules/network/google"
  version = "~> 5.0"

  project_id   = var.shared-services-project
  network_name = "shared-vpc-common"

  subnets = [

    {
      subnet_name               = "common-asia-se1"
      subnet_ip                 = "192.168.10.0/24"
      subnet_region             = "asia-southeast1"
      subnet_private_access     = false
      subnet_flow_logs          = false
      subnet_flow_logs_sampling = "0.5"
      subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
      subnet_flow_logs_interval = "INTERVAL_10_MIN"
    },
    {
      subnet_name               = "common-us-c1"
      subnet_ip                 = "192.168.11.0/24"
      subnet_region             = "us-central1"
      subnet_private_access     = false
      subnet_flow_logs          = false
      subnet_flow_logs_sampling = "0.5"
      subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
      subnet_flow_logs_interval = "INTERVAL_10_MIN"
    },
    {
      subnet_name               = "common-asia-s1"
      subnet_ip                 = "192.168.12.0/24"
      subnet_region             = "asia-south1"
      subnet_private_access     = false
      subnet_flow_logs          = false
      subnet_flow_logs_sampling = "0.5"
      subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
      subnet_flow_logs_interval = "INTERVAL_10_MIN"
    }
  ]
}
# # # Firewall Rules
# resource "google_compute_firewall" "vpc-host-common-01-allow-iap-rdp" {
#   name      = "vpc-host-common-allow-iap-rdp"
#   network   = module.shared-vpc-common.network_name
#   project   = var.shared-services-project
#   direction = "INGRESS"
#   priority  = 10000

#   log_config {
#     metadata = "INCLUDE_ALL_METADATA"
#   }

#   allow {
#     protocol = "tcp"
#     ports    = ["3389", ]
#   }

#   source_ranges = [
#     "35.235.240.0/20",
#   ]
# }
# resource "google_compute_firewall" "vpc-host-commmon-01-allow-iap-ssh" {
#   name      = "vpc-host-common-allow-iap-ssh"
#   network   = module.shared-vpc-common.network_name
#   project   = var.shared-services-project
#   direction = "INGRESS"
#   priority  = 10000

#   log_config {
#     metadata = "INCLUDE_ALL_METADATA"
#   }

#   allow {
#     protocol = "tcp"
#     ports    = ["22", ]
#   }

#   source_ranges = [
#     "35.235.240.0/20",
#   ]
# }
# resource "google_compute_firewall" "vpc-host-common-01-allow-icmp" {
#   name      = "vpc-host-common-allow-icmp"
#   network   = module.shared-vpc-common.network_name
#   project   = var.shared-services-project
#   direction = "INGRESS"
#   priority  = 10000

#   log_config {
#     metadata = "INCLUDE_ALL_METADATA"
#   }

#   allow {
#     protocol = "icmp"
#   }

#   source_ranges = [
#     "10.128.0.0/9",
#   ]
# }