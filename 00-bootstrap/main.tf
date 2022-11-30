terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">=4.43.0"
    }
  }
  backend "gcs" {
    bucket = "tf-backend-betalabs-co-in"
    prefix = "env01/00-bootstrap"
    impersonate_service_account = "tf-access-sa-org-admin@shared-services-env01-7fca.iam.gserviceaccount.com"
  }
}

provider "google" {
  # Configuration options
  project = "shared-services-env01-7fca"
  region  = "asia-south1"
  zone  = "asia-south1-c"
}