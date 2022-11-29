terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">=4.43.0"
    }
  }
  backend "gcs" {
    bucket = "tf-backend-betalabs-co-in"
    prefix = "env01/03-infra/001-tf-exec-vm"
  }
}

provider "google" {
  # Configuration options
  project = "shared-services-env01-7fca"
  region  = "asia-south1"

  user_project_override=true
}

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "e2-medium"
  zone = "asia-south1-c"

  boot_disk {
    initialize_params {
      image = "ubuntu-2204-lts"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    subnetwork = "https://www.googleapis.com/compute/v1/projects/shared-services-env01-7fca/regions/asia-south1/subnetworks/common-asia-s1"
    access_config {
        network_tier = "STANDARD"
    }
  }

  tags = [ "allow-ssh" ]

  service_account {
    # default scope . https://cloud.google.com/sdk/gcloud/reference/alpha/compute/instances/set-scopes#--scopes
    scopes = [
        "https://www.googleapis.com/auth/devstorage.read_only",
        "https://www.googleapis.com/auth/logging.write",
        "https://www.googleapis.com/auth/monitoring.write",
        "https://www.googleapis.com/auth/pubsub",
        "https://www.googleapis.com/auth/service.management.readonly",
        "https://www.googleapis.com/auth/servicecontrol",
        "https://www.googleapis.com/auth/trace.append",
    ]
  }
}
