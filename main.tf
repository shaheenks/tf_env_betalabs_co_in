terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.41.0"
    }
  }
  backend "gcs" {
    bucket = "tf-backend-betalabs-co-in"
  }
}

provider "google" {
  # Configuration options
  project = "tf-backend-common-bl101-en001"
  region  = "asia-south1"

}