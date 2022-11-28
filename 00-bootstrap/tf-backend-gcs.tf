# module "tf-backend" {
#   source="terraform-google-modules/project-factory/google"
#   version = "~> 12.0"

#   name="shared-services-env01"
#   random_project_id = true
#   auto_create_network = false
#   default_service_account = "disable"
#   enable_shared_vpc_host_project= true

#   org_id = var.org_id
#   folder_id=google_folder.common.name
#   billing_account=var.billing_account
# }

resource "google_storage_bucket" "tf-backend-gcs" {
  name    = "tf-backend-betalabs-co-in"
  project = module.shared-services-project.project_id

  location      = "asia-south1"
  force_destroy = true
  storage_class = "STANDARD"
  versioning {
    enabled = true
  }
}