# VPC and Subnets
module "vpc-host-dev" {
    source  = "terraform-google-modules/network/google"
    version = "~> 5.0"

    project_id   = module.vpc-host-dev-bl101-en001.project_id
    network_name = "vpc-host-dev"

    subnets = [
       
        {
            subnet_name           = "subnet-dev-asia-southeast1"
            subnet_ip             = "192.168.10.0/24"
            subnet_region         = "asia-southeast1"
            subnet_private_access = false
            subnet_flow_logs      = false
            subnet_flow_logs_sampling = "0.5"
            subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
            subnet_flow_logs_interval = "INTERVAL_10_MIN"
        },
        {
            subnet_name           = "subnet-dev-us-central1"
            subnet_ip             = "192.168.11.0/24"
            subnet_region         = "us-central1"
            subnet_private_access = false
            subnet_flow_logs      = false
            subnet_flow_logs_sampling = "0.5"
            subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
            subnet_flow_logs_interval = "INTERVAL_10_MIN"
        },
        {
            subnet_name           = "subnet-dev-asia-south1"
            subnet_ip             = "192.168.12.0/24"
            subnet_region         = "asia-south1"
            subnet_private_access = false
            subnet_flow_logs      = false
            subnet_flow_logs_sampling = "0.5"
            subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
            subnet_flow_logs_interval = "INTERVAL_10_MIN"
        }
    ]
}
# Firewall Rules
resource "google_compute_firewall" "vpc-host-dev-allow-iap-rdp" {
  name      = "vpc-host-dev-allow-iap-rdp"
  network   = module.vpc-host-dev.network_name
  project   = module.vpc-host-dev-bl101-en001.project_id
  direction = "INGRESS"
  priority  = 10000

  log_config {
      metadata = "INCLUDE_ALL_METADATA"
    }

  allow {
    protocol = "tcp"
    ports    = ["3389",]
  }

  source_ranges = [
  "35.235.240.0/20",
  ]
}
resource "google_compute_firewall" "vpc-host-dev-allow-iap-ssh" {
  name      = "vpc-host-dev-allow-iap-ssh"
  network   = module.vpc-host-dev.network_name
  project   = module.vpc-host-dev-bl101-en001.project_id
  direction = "INGRESS"
  priority  = 10000

  log_config {
      metadata = "INCLUDE_ALL_METADATA"
    }

  allow {
    protocol = "tcp"
    ports    = ["22",]
  }

  source_ranges = [
  "35.235.240.0/20",
  ]
}
resource "google_compute_firewall" "vpc-host-dev-allow-icmp" {
  name      = "vpc-host-dev-allow-icmp"
  network   = module.vpc-host-dev.network_name
  project   = module.vpc-host-dev-bl101-en001.project_id
  direction = "INGRESS"
  priority  = 10000

  log_config {
      metadata = "INCLUDE_ALL_METADATA"
    }

  allow {
    protocol = "icmp"
  }

  source_ranges = [
  "10.128.0.0/9",
  ]
}
# NAT Router and config

# VPC and Subnets
# module "vpc-host-prod" {
#     source  = "terraform-google-modules/network/google"
#     version = "~> 5.0"

#     project_id   = module.vpc-host-prod-bl101-en001.project_id
#     network_name = "vpc-host-prod"

#     subnets = [
       
#         {
#             subnet_name           = "subnet-prod-1"
#             subnet_ip             = "192.168.1.0/24"
#             subnet_region         = "asia-southeast1"
#             subnet_private_access = true
#             subnet_flow_logs      = true
#             subnet_flow_logs_sampling = "0.5"
#             subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
#             subnet_flow_logs_interval = "INTERVAL_10_MIN"
#         },
#         {
#             subnet_name           = "subnet-prod-2"
#             subnet_ip             = "192.168.2.0/24"
#             subnet_region         = "asia-southeast2"
#             subnet_private_access = true
#             subnet_flow_logs      = true
#             subnet_flow_logs_sampling = "0.5"
#             subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
#             subnet_flow_logs_interval = "INTERVAL_10_MIN"
#         },
#     ]
# }
# # Firewall Rules
# resource "google_compute_firewall" "vpc-host-prod-allow-iap-rdp" {
#   name      = "vpc-host-prod-allow-iap-rdp"
#   network   = module.vpc-host-prod.network_name
#   project   = module.vpc-host-prod-bl101-en001.project_id
#   direction = "INGRESS"
#   priority  = 10000

#   log_config {
#       metadata = "INCLUDE_ALL_METADATA"
#     }

#   allow {
#     protocol = "tcp"
#     ports    = ["3389",]
#   }

#   source_ranges = [
#   "35.235.240.0/20",
#   ]
# }
# resource "google_compute_firewall" "vpc-host-prod-allow-iap-ssh" {
#   name      = "vpc-host-prod-allow-iap-ssh"
#   network   = module.vpc-host-prod.network_name
#   project   = module.vpc-host-prod-bl101-en001.project_id
#   direction = "INGRESS"
#   priority  = 10000

#   log_config {
#       metadata = "INCLUDE_ALL_METADATA"
#     }

#   allow {
#     protocol = "tcp"
#     ports    = ["22",]
#   }

#   source_ranges = [
#   "35.235.240.0/20",
#   ]
# }
# resource "google_compute_firewall" "vpc-host-prod-allow-icmp" {
#   name      = "vpc-host-prod-allow-icmp"
#   network   = module.vpc-host-prod.network_name
#   project   = module.vpc-host-prod-bl101-en001.project_id
#   direction = "INGRESS"
#   priority  = 10000

#   log_config {
#       metadata = "INCLUDE_ALL_METADATA"
#     }

#   allow {
#     protocol = "icmp"
#   }

#   source_ranges = [
#   "10.128.0.0/9",
#   ]
# }
# # NAT Router and config

# # VPC and Subnets
# module "vpc-host-staging" {
#     source  = "terraform-google-modules/network/google"
#     version = "~> 5.0"

#     project_id   = module.vpc-host-nonprod-bl101-en001.project_id
#     network_name = "vpc-host-staging"

#     subnets = [
       
#         {
#             subnet_name           = "subnet-staging-1"
#             subnet_ip             = "192.168.3.0/24"
#             subnet_region         = "asia-southeast1"
#             subnet_private_access = true
#             subnet_flow_logs      = true
#             subnet_flow_logs_sampling = "0.5"
#             subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
#             subnet_flow_logs_interval = "INTERVAL_10_MIN"
#         },
#         {
#             subnet_name           = "subnet-staging-2"
#             subnet_ip             = "192.168.4.0/24"
#             subnet_region         = "asia-southeast2"
#             subnet_private_access = true
#             subnet_flow_logs      = true
#             subnet_flow_logs_sampling = "0.5"
#             subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
#             subnet_flow_logs_interval = "INTERVAL_10_MIN"
#         },
#     ]
# }
# # Firewall Rules
# resource "google_compute_firewall" "vpc-host-staging-allow-iap-rdp" {
#   name      = "vpc-host-staging-allow-iap-rdp"
#   network   = module.vpc-host-staging.network_name
#   project   = module.vpc-host-nonprod-bl101-en001.project_id
#   direction = "INGRESS"
#   priority  = 10000

#   log_config {
#       metadata = "INCLUDE_ALL_METADATA"
#     }

#   allow {
#     protocol = "tcp"
#     ports    = ["3389",]
#   }

#   source_ranges = [
#   "35.235.240.0/20",
#   ]
# }
# resource "google_compute_firewall" "vpc-host-staging-allow-iap-ssh" {
#   name      = "vpc-host-staging-allow-iap-ssh"
#   network   = module.vpc-host-staging.network_name
#   project   = module.vpc-host-nonprod-bl101-en001.project_id
#   direction = "INGRESS"
#   priority  = 10000

#   log_config {
#       metadata = "INCLUDE_ALL_METADATA"
#     }

#   allow {
#     protocol = "tcp"
#     ports    = ["22",]
#   }

#   source_ranges = [
#   "35.235.240.0/20",
#   ]
# }
# resource "google_compute_firewall" "vpc-host-staging-allow-icmp" {
#   name      = "vpc-host-staging-allow-icmp"
#   network   = module.vpc-host-staging.network_name
#   project   = module.vpc-host-nonprod-bl101-en001.project_id
#   direction = "INGRESS"
#   priority  = 10000

#   log_config {
#       metadata = "INCLUDE_ALL_METADATA"
#     }

#   allow {
#     protocol = "icmp"
#   }

#   source_ranges = [
#   "10.128.0.0/9",
#   ]
# }
# NAT Router and config
