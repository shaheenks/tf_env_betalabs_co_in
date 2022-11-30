terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.43.0"
    }
  }
  backend "gcs" {
    bucket = "tf-backend-betalabs-co-in"
    prefix = "env01/02-networks"
    impersonate_service_account = "tf-access-sa-env-admin@shared-services-env01-7fca.iam.gserviceaccount.com"
  }
}

provider "google" {
  # Configuration options
  project = "shared-services-env01-7fca"
  region  = "asia-south1"
}