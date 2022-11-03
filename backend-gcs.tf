resource "google_storage_bucket" "tf-backend" {
  name    = "tf-backend-betalabs-co-in"
  project = google_project.tf-backend-common.project_id

  location      = "asia-south1"
  force_destroy = false
  storage_class = "STANDARD"
}