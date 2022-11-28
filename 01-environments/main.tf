terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.43.0"
    }
  }
  backend "gcs" {
    bucket = "tf-backend-betalabs-co-in"
    prefix = "env01/01-environments"
  }
}

provider "google" {
  # Configuration options
  project = "shared-services-env01-7fca"
  region  = "asia-south1"
}