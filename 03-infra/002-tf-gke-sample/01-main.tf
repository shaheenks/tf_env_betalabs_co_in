terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">=4.43.0"
    }
  }
  backend "gcs" {
    bucket = "tf-backend-betalabs-co-in"
    prefix = "env01/03-infra/002-tf-gke-sample"
  }
}

provider "google" {
  # Configuration options
  project = "playground-dev-env01-6712"
  region  = "us-central1"
}

variable "gke_username" {
  default     = "shaheen"
  description = "gke username"
}

variable "gke_password" {
  default     = "shaheen11101989"
  description = "gke password"
}

variable "gke_num_nodes" {
  default     = 2
  description = "number of gke nodes"
}

# GKE cluster
resource "google_container_cluster" "primary" {
  name     = "terraform-sample-gke"
  location = "us-central1"
  
  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  # networking_mode = "VPC_NATIVE"
  ip_allocation_policy {
    cluster_secondary_range_name="common-us-c1-pods-range"
    services_secondary_range_name="common-us-c1-services-range"
  }
  network    = "https://www.googleapis.com/compute/v1/projects/shared-services-env01-7fca/global/networks/shared-vpc-common"
  subnetwork = "https://www.googleapis.com/compute/v1/projects/shared-services-env01-7fca/regions/us-central1/subnetworks/common-central-c1"
}

# Separately Managed Node Pool
resource "google_container_node_pool" "primary_nodes" {
  name       = "${google_container_cluster.primary.name}"
  location   = "us-central1"
  cluster    = google_container_cluster.primary.name
  node_count = var.gke_num_nodes

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {
      env = "playground-dev-env01-6712"
    }

    # preemptible  = true
    machine_type = "n1-standard-1"
    tags         = ["gke-node"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}
