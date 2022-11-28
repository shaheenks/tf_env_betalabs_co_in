resource "google_folder" "production-folder" {
  display_name = "Production"
  parent       = var.workloads-folder
}