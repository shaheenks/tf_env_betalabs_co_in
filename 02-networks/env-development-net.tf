# VPC and Subnets
module "env-dev-vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 5.0"

  project_id   = "playground-dev-env01-6712"
  network_name = "env-dev-vpc"

  delete_default_internet_gateway_routes = true

  subnets = [

    {
      subnet_name               = "env-dev-subnet-asia-se1"
      subnet_ip                 = "192.168.20.0/24"
      subnet_region             = "asia-southeast1"
      subnet_private_access     = false
      subnet_flow_logs          = false
      subnet_flow_logs_sampling = "0.5"
      subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
      subnet_flow_logs_interval = "INTERVAL_10_MIN"
    },

    {
      subnet_name               = "env-dev-subnet-asia-s1"
      subnet_ip                 = "192.168.25.0/24"
      subnet_region             = "asia-south1"
      subnet_private_access     = false
      subnet_flow_logs          = false
      subnet_flow_logs_sampling = "0.5"
      subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
      subnet_flow_logs_interval = "INTERVAL_10_MIN"
    }
  ]

#   secondary_ranges = {
#     "common-us-c1" = [ {
#       ip_cidr_range = "10.0.0.0/8"
#       range_name = "common-us-c1-pods-range"
#     },
#     {
#       ip_cidr_range = "192.168.13.0/24"
#       range_name = "common-us-c1-services-range"
#     }
#     ]
#   }

#   routes = [
#       {
#         name = "rt-vpc-host-nonprod-1000-egress-internet-default"
#         description = "Tag based route through IGW to access internet"
#         destination_range = "0.0.0.0/0"
#         priority = "1000"
#         next_hop_internet = "true"
#         tags = "egress-internet"
#       },
#     ]
}

# # Firewall Rules
resource "google_compute_firewall" "env-dev-vpc-allow-iap" {
  name      = "env-dev-vpc-allow-iap"
  network   = module.env-dev-vpc.network_name
  project   = "playground-dev-env01-6712"
  direction = "INGRESS"
  priority  = 10000

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }

  allow {
    protocol = "tcp"
    ports    = ["3389", "22"]
  }

  source_ranges = [
    "35.235.240.0/20",
  ]
}