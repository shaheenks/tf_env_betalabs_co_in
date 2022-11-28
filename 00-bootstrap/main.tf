terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.43.0"
    }
  }
  backend "gcs" {
    bucket = "tf-backend-betalabs-co-in"
    prefix = "env01/00-bootstrap"
  }
}

provider "google" {
  # Configuration options
  project = "shared-services-env01"
  region  = "asia-south1"

}