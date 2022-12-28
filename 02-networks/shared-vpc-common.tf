# VPC and Subnets
module "shared-vpc-common" {
  source  = "terraform-google-modules/network/google"
  version = "~> 5.0"

  project_id   = var.shared-services-project
  network_name = "shared-vpc-common"

  delete_default_internet_gateway_routes = true

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

  secondary_ranges = {
    "common-us-c1" = [ {
      ip_cidr_range = "10.0.0.0/8"
      range_name = "common-us-c1-pods-range"
    },
    {
      ip_cidr_range = "192.168.13.0/24"
      range_name = "common-us-c1-services-range"
    }
    ]
  }

  routes = [
      {
        name = "rt-vpc-host-nonprod-1000-egress-internet-default"
        description = "Tag based route through IGW to access internet"
        destination_range = "0.0.0.0/0"
        priority = "1000"
        next_hop_internet = "true"
        tags = "egress-internet"
      },
    ]
}

# NAT Router and config
resource "google_compute_router" "router-asia-southeast1" {
  name    = "router-asia-southeast1-common"
  project = var.shared-services-project
  region  = "asia-southeast1"
  network = module.shared-vpc-common.network_self_link
}

resource "google_compute_router_nat" "router-nat-asia-southeast1" {
  name                               = "router-nat-asia-southeast1-common"
  router                             = google_compute_router.router-asia-southeast1.name
  region                             = google_compute_router.router-asia-southeast1.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}


# # Firewall Rules
resource "google_compute_firewall" "vpc-host-common-01-allow-iap-rdp" {
  name      = "vpc-host-common-allow-iap-rdp"
  network   = module.shared-vpc-common.network_name
  project   = var.shared-services-project
  direction = "INGRESS"
  priority  = 10000

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }

  allow {
    protocol = "tcp"
    ports    = ["3389", ]
  }

  source_ranges = [
    "35.235.240.0/20",
  ]
}
resource "google_compute_firewall" "vpc-host-commmon-01-allow-iap-ssh" {
  name      = "vpc-host-common-allow-iap-ssh"
  network   = module.shared-vpc-common.network_name
  project   = var.shared-services-project
  direction = "INGRESS"
  priority  = 10000

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", ]
  }

  source_ranges = [
    "35.235.240.0/20",
  ]
}
resource "google_compute_firewall" "vpc-host-common-01-allow-icmp" {
  name      = "vpc-host-common-allow-icmp"
  network   = module.shared-vpc-common.network_name
  project   = var.shared-services-project
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

resource "google_compute_firewall" "vpc-host-commmon-allow-ssh" {
  name      = "vpc-host-common-allow-ssh"
  network   = module.shared-vpc-common.network_name
  project   = var.shared-services-project
  direction = "INGRESS"
  priority  = 10000

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", ]
  }

  source_ranges = [
    "0.0.0.0/0",
  ]

  target_tags = ["allow-ssh"]
}

resource "google_compute_firewall" "vpc-host-commmon-allow-rdp" {
  name      = "vpc-host-common-allow-rdp"
  network   = module.shared-vpc-common.network_name
  project   = var.shared-services-project
  direction = "INGRESS"
  priority  = 10000

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }

  allow {
    protocol = "tcp"
    ports    = ["3389", ]
  }

  source_ranges = [
    "0.0.0.0/0",
  ]

  target_tags = ["allow-rdp"]
}

