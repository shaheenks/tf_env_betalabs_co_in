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

resource "google_storage_bucket" "tf-backend-common-env01" {
  name    = "tf-backend-betalabs-co-in"
  project = module.shared-services-env01.project_id

  location      = "asia-south1"
  force_destroy = true
  storage_class = "STANDARD"
  versioning {
    enabled = true
  }
}

module "logsink-682729577898-logbucketsink" {
  source  = "terraform-google-modules/log-export/google"
  version = "~> 7.3.0"

  destination_uri      = module.betalabs-co-in-logging-destination.destination_uri
  log_sink_name        = "682729577898-logbucketsink"
  parent_resource_id   = var.org_id
  parent_resource_type = "organization"
  include_children     = true
}

module "betalabs-co-in-logging-destination" {
  source  = "terraform-google-modules/log-export/google//modules/logbucket"
  version = "~> 7.4.1"

  project_id               = module.shared-services-env01.project_id
  name                     = "betalabs-co-in-logging"
  location                 = "global"
  retention_days           = 365
  log_sink_writer_identity = module.logsink-682729577898-logbucketsink.writer_identity
}